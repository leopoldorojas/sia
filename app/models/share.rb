class Share < ActiveRecord::Base
  belongs_to :sale, foreign_key: "share_operation_id"
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

    def operation_since this_date
      joins(:share_operation).where("share_operations.operation_date >= (?)", this_date)
    end

    def operation_until this_date
      joins(:share_operation).where("share_operations.operation_date <= (?)", this_date)
    end

    def share_holder_is this_share_holder_id
      joins(:share_holder).where(share_holders: {id: this_share_holder_id})
    end
  end 

end
