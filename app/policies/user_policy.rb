class UserPolicy < ApplicationPolicy
  def index?
    user&.admin?
  end

  def destroy?
    # recordは引数で渡されてきた削除対象のユーザー。userはcurrent_user。
    # 管理者かつ削除対象のユーザーがcurrent_userでない場合にtrueを返す。
    user&.admin? && user != record
  end

  class Scope < ApplicationPolicy::Scope
    # 継承元のApplicationPolicy::Scopeのresolveメソッドを上書き。
    # 管理者の場合は引数で渡されたUser.all。管理者でない場合はUser.noneを返す。
    def resolve
      user&.admin? ? scope.all : scope.none
    end
  end
end
