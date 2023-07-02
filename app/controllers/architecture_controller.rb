class ArchitectureController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Architecture.ransack(params[:q])
    @architecture = @q.result(distinct: true).where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
  end

  def new
    @architecture = Architecture.new
  end

  def create
    @architecture = current_user.architecture.build(architecture_params)
    if params[:architecture][:new_images].present?
      @architecture.images.attach(params[:architecture][:new_images])
    end
    if @architecture.save
      redirect_to architecture_index_path, notice: t('defaults.message.created', item: Architecture.model_name.human)
    else
      flash.now['notice'] = t('defaults.message.not_created', item: Architecture.model_name.human)
      render :new
    end
  end

  def show
    @architecture = Architecture.find(params[:id])
    @images = @architecture.images.map { |image| rails_representation_path(image.variant(resize:'2048x2048').processed) }.to_json.html_safe
  end

  def edit
    @architecture = current_user.architecture.find(params[:id])
  end

  def update
    @architecture = current_user.architecture.find(params[:id])
    existing_images = params[:architecture][:existing_images]
    new_images = params[:architecture][:new_images]
    
    if existing_images.present? || new_images.present?
      @architecture.images.where.not(id: existing_images).purge
    else
      @architecture.errors.add(:images, '写真が一枚も選択されていません')
    end
  
    if new_images.present?
      @architecture.images.attach(new_images)
    end
      
    if @architecture.errors.empty?
      if @architecture.update(architecture_params)
        redirect_to @architecture, notice: t('defaults.message.updated', item: Architecture.model_name.human)
      else
        flash.now['notice'] = t('defaults.message.not_updated', item: Architecture.model_name.human)
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

  private

  def architecture_params
    params.require(:architecture).permit(:name, :location, :architect, :description, :open_range, :experience, images: [], tag_ids: [])
  end
end
