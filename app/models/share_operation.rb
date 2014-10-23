class ShareOperation < ActiveRecord::Base
  belongs_to :share_holder
  has_many :receipts
  has_many :shares

  before_save :assign_shares shares_number

  private

	  def assign_shares shares_number
	  	1.upto(shares_number) { self.shares << Share.get_next_share }
	  end

	  def assign_shares shares_number
	  	self.shares << Share.get_next_shares shares_number 
	  end

end
