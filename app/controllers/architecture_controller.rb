class ArchitectureController < ApplicationController
  def index
    @architecture = Architecture.where(user_id: current_user.id).includes(:user).order(created_at: :desc)
  end

  def new
    @architecture = Architecture.new
  end

  def create
    @architecture = current_user.architecture.build(architecture_params)
    if @architecture.save
      redirect_to architecture_index_path, notice: t('defaults.message.created', item: Architecture.model_name.human)
    else
      flash.now['notice'] = t('defaults.message.not_created', item: Architecture.model_name.human)
      render :new
    end
  end

  def show
    @architecture = current_user.architecture.find(params[:id])
  end

  def edit
    @architecture = current_user.architecture.find(params[:id])
  end

  def update
    @architecture = current_user.architecture.find(params[:id])
    if @architecture.update(architecture_params)
      redirect_to @architecture, notice: t('defaults.message.updated', item: Architecture.model_name.human)
    else
      flash.now['notice'] = t('defaults.message.not_updated', item: Architecture.model_name.human)
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
    params.require(:architecture).permit(:name, :location, :architect, :description, :open_range, { images: [] }, { images_cache: [] })
  end
end
