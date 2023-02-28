class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    if user.admin?
      true
    else
      record.id == user.id
    end
  end

  def destroy?
    user.admin?
  end
end
