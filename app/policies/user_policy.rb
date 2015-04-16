class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.max_privilege user.role
    end
  end

  def manage?
    user.is_at_least? :company_admin
  end
end
