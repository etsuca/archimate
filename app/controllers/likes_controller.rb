class LikesController < ApplicationController
  def index
    @q = current_user.like_architecture.ransack(params[:q])
    @like_architecture = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def create
    architecture = Architecture.find(params[:architecture_id])
    current_user.like(architecture)
    redirect_back fallback_location: root_path, success: t('.success')
  end

  def destroy
    architecture = current_user.likes.find_by(architecture_id: params[:id]).architecture
    current_user.unlike(architecture)
    redirect_to likes_path, success: t('.success')
  end
end
