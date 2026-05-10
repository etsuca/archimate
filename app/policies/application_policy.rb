class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  class Scope
    attr_reader :user, :scope

    # userにはデフォルトでcurrent_userが渡される。今回の場合、scopeにはUserクラスが渡されている。
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # user_scope
    def resolve
      scope.none
    end
  end
end
