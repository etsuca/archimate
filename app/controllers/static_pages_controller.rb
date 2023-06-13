class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[welcome]

  def top
    others_architecture = Architecture.not_by(current_user)
    user_liked_architecture_ids = Like.where(user_id: current_user.id).pluck(:architecture_id)
    @architecture = others_architecture.where.not(id: user_liked_architecture_ids).where(open_range: 'publish').shuffle.first
    @images = @architecture&.images.to_json.html_safe
  end

  def welcome
  end 
end
