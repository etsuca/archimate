class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @architectures_count = current_user.architecture.count
    @liked_architectures_count = current_user.like_architecture.count
    @received_likes_count = Like.where(architecture_id: current_user.architecture.select(:id)).count
    @first_architecture_created_at = l current_user.architecture.order(:created_at).first.created_at
    @visited_prefecture_count = current_user.architecture.map { |a| a.pref }.uniq.count
    @prefecture_completion_percentage = (@visited_prefecture_count / 47.00 * 100).floor
  end
end
