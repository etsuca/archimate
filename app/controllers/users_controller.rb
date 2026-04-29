class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @buildings_count = current_user.buildings.count
    @liked_buildings_count = current_user.liked_buildings.count
    @received_likes_count = Like.where(building_id: current_user.buildings.select(:id)).count
    first_building = current_user.buildings.order(:created_at).first
    @first_building_created_at = l(first_building.created_at) if first_building
    @visited_prefecture_count = current_user.buildings.map { |a| a.pref }.uniq.count
    @prefecture_completion_percentage = (@visited_prefecture_count / 47.00 * 100).floor
  end
end
