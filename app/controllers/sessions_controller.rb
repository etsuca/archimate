class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create failure]

  def new
    @user = User.new
  end

  def create
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])
    session[:user_id] = user.uid
    redirect_to root_url, notice: (t '.success')
  end

  def destroy
    reset_session
    redirect_to welcome_path, notice: (t '.success')
  end

  def failure
    redirect_to login_path
  end
end
