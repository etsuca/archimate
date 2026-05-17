class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # 対応するUserPolicyの同名のメソッド（index?メソッド）が呼び出される。
    # 第1引数には自動的にcurrent_userが渡され、第2引数でUserクラスを渡している。
    # falseの場合、その時点でPundit::NotAuthorizedErrorを投げて処理が中断される。
    authorize User
    # policy_scopeはデフォルトでUserPolicy::Scopeのresolveメソッドを呼び出す。
    # 第1引数には自動的にcurrent_userが渡され、第2引数でUserクラスを渡している。
    @users = policy_scope(User).order(created_at: :desc).page(params[:page])
  end

  def destroy
    # @user = ビューからparams[:id]で指定された削除対象のユーザー
    @user = User.find(params[:id])
    # 対応するUserPolicyの同名のメソッド（destroy?メソッド）が呼び出される。
    authorize @user
    @user.destroy!
    redirect_to admin_users_path, notice: t('defaults.message.deleted', item: User.model_name.human)
  end
end
