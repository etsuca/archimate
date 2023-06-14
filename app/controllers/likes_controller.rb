class LikesController < ApplicationController
  def index
    @q = current_user.like_architecture.ransack(params[:q])
    @like_architecture = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def create
    @architecture = Architecture.find(params[:architecture_id])
    current_user.like(@architecture)
    if URI(request.referer.to_s).path == root_path
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @architecture = current_user.likes.find(params[:id]).architecture
    current_user.unlike(@architecture)
    if URI(request.referer.to_s).path == architecture_path(@architecture)
      redirect_to likes_path
    end
  end
end
