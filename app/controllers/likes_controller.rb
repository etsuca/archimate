class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @building = Building.find(params[:building_id])
    current_user.like(@building)
    redirect_back fallback_location: root_path if URI(request.referer.to_s).path == root_path
  end

  def destroy
    @building = current_user.likes.find(params[:id]).building
    current_user.unlike(@building)
  end
end
