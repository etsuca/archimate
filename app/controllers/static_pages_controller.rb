class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[welcome]

  def top
    user_liked_architecture_ids = Like.where(user_id: current_user.id).pluck(:architecture_id)
    architecture = Architecture.where.not(id: user_liked_architecture_ids).where(open_range: 'publish')
    @architecture = architecture.not_by(current_user).offset( rand(architecture.not_by(current_user).count) ).first
  end

  def welcome
  end 
end
