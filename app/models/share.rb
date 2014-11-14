class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  belongs_to :share_holder
  delegate :share_type, to: :share_issue
  validates :identifier, uniqueness: true

  def self.get_next_shares shares_number
  	shares_number ||= 0
  	share_scope = shares_number > 0 ? where(share_operation_id: [0, nil]).order(:identifier).first(shares_number) : none
	  shares_number_assigned = share_scope.count
  	[ share_scope, shares_number_assigned ]
  end

  def holder_name
  	share_operation.try(:share_holder).try(:name) || ""
  end

end
