class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @liked_count = current_user.architecture.inject(0) { |sum, architecture| sum + architecture.likes.count }
  end
end
