class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[welcome]

  def top
  end

  def welcome
  end 
end
