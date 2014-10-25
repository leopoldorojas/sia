class ShareOperation < ActiveRecord::Base
  belongs_to :share_holder
  has_many :receipts
  has_many :shares

  before_save :assign_shares

  private

	  def assign_shares
	  	self.shares << Share.get_next_shares(shares_number)
	  end

end
