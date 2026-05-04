class BuildingsController < ApplicationController
  include BaseQueryConcern
  include BuildingImagesConcern
  before_action :authenticate_user!
  before_action :find_building, only: %i[edit update destroy]
  before_action :set_tags, only: %i[new edit check_in create update]

  def index
    @buildings_size = Building.from(@base_query.select(:id), :buildings).count
    @buildings = @base_query.distinct.order(created_at: :desc).page(params[:page])
  end

  def show
    @building = Building.find(params[:id])
  end

  def new
    @building = Building.new
  end

  def edit; end

  def create
    @building = current_user.buildings.build(building_params)

    if save_building_with_images(@building)
      redirect_to @building, notice: t('defaults.message.created', item: Building.model_name.human)
    else
      flash.now['notice'] = @building.errors.full_messages.first
      render :new
    end
  end

  def update
    if update_building_with_images(@building)
      redirect_to @building, notice: t('defaults.message.updated', item: Building.model_name.human)
    else
      flash.now['notice'] = @building.errors.full_messages.first
      render :edit
    end
  end

  def destroy
    @building.destroy!
    redirect_to buildings_path, notice: t('defaults.message.deleted', item: Building.model_name.human)
  end

  def check_in
    @building = Building.new(
      name: params[:name],
      pref: params[:pref],
      location: params[:location],
      open_range: params[:open_range],
      experience: params[:experience],
      architect: params[:architect]
    )
  end

  private

  def building_params
    params.require(:building).permit(:name, :pref, :location, :architect, :description, :open_range, :experience, images: [], tag_ids: [])
  end

  def find_building
    @building = current_user.buildings.find(params[:id])
  end

  def set_tags
    @tags = Tag.all
  end

  def save_building_with_images(building)
    new_images = params[:building][:new_images]

    if new_images.present?
      building.images.transaction do
        resize_and_convert(new_images)
        raise ActiveRecord::Rollback if building.errors.any?

        building.images.attach(new_images)
      end
    else
      building.errors.add(:images, t('errors.messages.no_picture_selected'))
      false
    end

    building.errors.empty? && building.save
  end

  def update_building_with_images(building)
    existing_images = params[:building][:existing_images]
    new_images = params[:building][:new_images]

    if existing_images.present? || new_images.present?
      building.images.transaction do
        resize_and_convert(new_images) if new_images.present?
        raise ActiveRecord::Rollback if building.errors.any?

        building.images.where.not(id: existing_images).purge
        building.images.attach(new_images) if new_images.present?
      end
    else
      building.errors.add(:images, t('errors.messages.no_picture_selected'))
      false
    end

    building.errors.empty? && building.update(building_params)
  end
end
