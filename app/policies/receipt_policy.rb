class ReceiptPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is?(:superadmin)
        scope.all
      else
        scope.none
      end
    end
  end

  def create?
    user.is_at_least? :superadmin
  end

end