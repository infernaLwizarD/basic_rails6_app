class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.by_state('active')
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

  def lock?
    record.kept? && !record.locked_at? && user.admin?
  end

  def unlock?
    record.kept? && record.locked_at? && user.admin?
  end

  def restore?
    record.discarded? && user.admin?
  end
end
