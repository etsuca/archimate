class ArchitectureController < ApplicationController
  def index
    @architecture = Architecture.all.includes(:user, :open_range).order(created_at: :desc)
  end

  def new
    @architecture = Architecture.new
  end

  def create
    @architecture = Architecture.new(architecture_params)
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
    params.require(:architecture).permit(:name, :description, :user_id, :open_range_id)
  end
end
