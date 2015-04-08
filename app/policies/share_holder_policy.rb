class ShareHolderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_at_least?(:admin)
        scope.all
      else
        #Multitenancy prepared: scope.where(credit_company: user.credit_company)
        scope.all
      end
    end
  end

  def create?
    user.is_at_least? :company_admin
  end

  def edit?
    create?
  end

  def block_allowed_fields?
    user.is_at_least? :admin
  end

  def destroy?
    edit? 
  end

end