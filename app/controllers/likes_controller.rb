class LikesController < ApplicationController
  def create
    architecture = Architecture.find(params[:architecture_id])
    current_user.like(architecture)
    redirect_back fallback_location: root_path, success: t('.success')
  end

  def destroy
    architecture = current_user.likes.find(params[:id]).architecture
    current_user.unlike(architecture)
    redirect_back fallback_location: root_path, success: t('.success')
  end
end
