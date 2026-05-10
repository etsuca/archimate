class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # 対応するUserPolicyの同名のメソッド（index?メソッド）が呼び出される。
    # 第1引数には自動的にcurrent_userが渡され、第2引数でUserクラスを渡している。
    # falseの場合、その時点でPundit::NotAuthorizedErrorを投げて処理が中断される。
    authorize User
    # policy_scopeはデフォルトでApplicationPolicy::Scopeのresolveメソッドを呼び出す。
    # 第1引数には自動的にcurrent_userが渡され、。第2引数でUserクラスを渡している。
    @users = policy_scope(User).order(created_at: :desc).page(params[:page])
  end
end
