class ShareTypePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def manage?
    user.is_at_least? :company_admin
  end
end