class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  belongs_to :share_holder
  delegate :share_type, to: :share_issue
  delegate :value, to: :share_type
  validates :identifier, uniqueness: true, on: :create

  class << self
	  def get_next_shares shares_required, share_type_id
	  	shares_of_type = get_shares_of_type share_type_id
	  	shares_required && shares_required > 0 ? shares_of_type.where(share_operation_id: [0, nil]).order(:identifier).limit(shares_required) : none
	  end

    def get_shares_of_type share_type_id
      joins(:share_issue).where(share_issues: { share_type_id: share_type_id })
    end

    def assign_shares_to(holder, these_shares)
      where(id: these_shares.map(&:id)).update_all(share_holder_id: holder.id)
    end

    def operation_since
    end

    def operation_until
    end
  end 

end
