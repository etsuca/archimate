class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show; end
  
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['notice'] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy!
    redirect_to login_path, notice: t('defaults.message.deleted', item: User.model_name.human)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar, :avatar_cache)
  end
end