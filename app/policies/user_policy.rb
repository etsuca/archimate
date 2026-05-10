class UserPolicy < ApplicationPolicy
  def index?
    user&.admin?
  end

  class Scope < ApplicationPolicy::Scope
    # 継承元のApplicationPolicy::Scopeのresolveメソッドを上書き。
    def resolve
      user&.admin? ? scope.all : scope.none
    end
  end
end
