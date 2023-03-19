class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.kept
      end
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
    record.kept? && if user.admin?
                      true
                    else
                      record.id == user.id
                    end
  end

  def destroy?
    record.kept? && user.admin?
  end
end
