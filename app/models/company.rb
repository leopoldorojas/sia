class Company < ActiveRecord::Base
	has_many :share_issues
  
  def issued_shares_upto final_share
  end
end
