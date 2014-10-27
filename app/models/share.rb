class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  delegate :share_type, to: :share_issue

  def self.get_next_shares shares_number
  	shares_number ||= 0
  	share_scope = shares_number > 0 ? where(share_operation_id: [0, nil]).order(:number).first(shares_number) : none
	  shares_number_assigned = share_scope.count
  	[ share_scope, shares_number_assigned ]
  end

end
