class Company < ActiveRecord::Base
	has_many :share_types
	has_many :share_issues, through: :share_types
  
  def issued_shares_upto final_share
  	self.last_share_issued = final_share
  	save
  end

end
