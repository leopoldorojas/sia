class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  belongs_to :share_holder
  delegate :share_type, to: :share_issue
  validates :identifier, uniqueness: true

  def self.get_next_shares shares_required
  	shares_required ||= 0
  	share_scope = shares_required > 0 ? where(share_operation_id: [0, nil]).order(:identifier).first(shares_required) : none
	  shares_assigned = share_scope.count
  	[ share_scope, shares_assigned ]
  end

end
