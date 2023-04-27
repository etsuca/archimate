class ArchitectureController < ApplicationController
  def index
    @architecture = Architecture.all.includes(:user).order(created_at: :desc)
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
    @architecture = Architecture.find(params[:id])
  end

  private

  def architecture_params
    params.require(:architecture).permit(:name, :location, :architect, :description, :open_range, { images: [] }, { images_cache: [] })
  end
end
