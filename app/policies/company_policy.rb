class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def manage?
    user.is_at_least? :superadmin
  end

end
