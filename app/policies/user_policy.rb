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

  def supermanage?
    user.is? :superadmin
  end
end
