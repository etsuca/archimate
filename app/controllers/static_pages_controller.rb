class StaticPagesController < ApplicationController
  include ArchitectureHelper
  before_action :authenticate_user!, only: %i[top]

  def top
    @architecture = random_architecture
    @images = architecture_images_url(@architecture)
  end

  def welcome; end

  def terms; end

  def privacy_policy; end
end
