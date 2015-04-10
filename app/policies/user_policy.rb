class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is?(:superadmin)
        scope.all
      else
        scope.where.not(role: 'superadmin')
      end
    end
  end

  def manage?
    user.is_at_least? :admin
  end
end
