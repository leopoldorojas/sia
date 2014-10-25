class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  delegate :share_type, to: :share_issue

  def self.get_next_shares shares_number
  	where(share_operation_id: [0, nil]).order(:number).first(shares_number)
  end

end
