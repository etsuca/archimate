# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def guest_login
    redirect_to root_path, alert: 'すでにログインしています' if current_user

    random_value = SecureRandom.hex
    user = User.create!(name: 'ゲストユーザー', email: "guest#{random_value}@example.com", password: random_value)
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。ログアウトする前にプロフィールを更新してください。'
  end
 
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
