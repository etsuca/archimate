class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: %i[top]

  def top
    others_architecture = Architecture.not_by(current_user)
    user_liked_architecture_ids = Like.where(user_id: current_user.id).pluck(:architecture_id)
    @architecture = others_architecture.where.not(id: user_liked_architecture_ids).where(open_range: 'publish').sample
    @images = @architecture.images.map { |image| rails_blob_path(image) }.to_json.html_safe if @architecture
  end

  def welcome; end

  def terms; end

  def privacy_policy; end
end
