class ArchitectureController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Architecture.ransack(params[:q])
    @architecture = @q.result(distinct: true).where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
  end

  def show
    @architecture = Architecture.find(params[:id])
    @images = @architecture.images.map { |image| rails_blob_path(image) }.to_json.html_safe
  end

  def new
    @architecture = Architecture.new
  end

  def edit
    @architecture = current_user.architecture.find(params[:id])
  end

  def create
    @architecture = current_user.architecture.build(architecture_params)
    new_images = params[:architecture][:new_images]

    if new_images.present?
      @architecture.images.transaction do
        resize_and_convert(new_images)
        raise ActiveRecord::Rollback if @architecture.errors.any?

        @architecture.images.attach(new_images)
      end
    else
      @architecture.errors.add(:images, t('errors.messages.no_picture_selected'))
    end

    if @architecture.errors.empty?
      if @architecture.save
        redirect_to @architecture, notice: t('defaults.message.created', item: Architecture.model_name.human)
      else
        flash.now['notice'] = @architecture.errors.full_messages.first
        render :new
      end
    else
      flash.now['notice'] = @architecture.errors.full_messages.first
      render :new
    end
  end

  def update
    @architecture = current_user.architecture.find(params[:id])
    existing_images = params[:architecture][:existing_images]
    new_images = params[:architecture][:new_images]

    if existing_images.present? || new_images.present?
      @architecture.images.transaction do
        resize_and_convert(new_images) if new_images.present?
        raise ActiveRecord::Rollback if @architecture.errors.any?

        @architecture.images.where.not(id: existing_images).purge
        @architecture.images.attach(new_images) if new_images.present?
      end
    else
      @architecture.errors.add(:images, t('errors.messages.no_picture_selected'))
    end

    if @architecture.errors.empty?
      if @architecture.update(architecture_params)
        redirect_to @architecture, notice: t('defaults.message.updated', item: Architecture.model_name.human)
      else
        flash.now['notice'] = @architecture.errors.full_messages.first
        render :edit
      end
    else
      flash.now['notice'] = @architecture.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @architecture = current_user.architecture.find(params[:id])
    @architecture.destroy!
    redirect_to architecture_index_path, notice: t('defaults.message.deleted', item: Architecture.model_name.human)
  end

  def check_in
    @architecture = Architecture.new
    @name = params[:name]
    @pref = params[:pref]
    @location = params[:location]
    @open_range = params[:open_range]
    @experience = params[:experience]
    @architect = params[:architect]
  end

  private

  def architecture_params
    params.require(:architecture).permit(:name, :pref, :location, :architect, :description, :open_range, :experience, images: [], tag_ids: [])
  end

  def resize_and_convert(images)
    images.each do |image|
      if image.content_type.start_with?('image/jpeg', 'image/png', 'image/heic', 'image/heif')
        image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).resize_to_fit(1920, 1920).call
        image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).convert('jpg').call if image.content_type.start_with?('image/heic', 'image/heif')
      else
        @architecture.errors.add(:images, t('errors.messages.invalid_file_type'))
      end
    end
  end
end
