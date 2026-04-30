class StaticPagesController < ApplicationController
  include BuildingsHelper
  before_action :authenticate_user!, only: %i[top]

  def top
    @building = random_building
  end

  def welcome; end

  def terms; end

  def privacy_policy; end
end
