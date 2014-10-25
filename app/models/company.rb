class Company < ActiveRecord::Base
	has_many :share_issues
	belongs_to :share_type		# A Company has one default share type
  
  def issued_shares_upto final_share
  	self.last_share_issued = final_share
  	save
  end

end
