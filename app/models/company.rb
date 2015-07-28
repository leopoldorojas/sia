class Company < ActiveRecord::Base
	has_many :share_types
	has_many :share_issues, through: :share_types
	has_many :users
  
  def issued_shares_upto final_share
  	self.last_share_issued = final_share
  	save
  end

  def issued_shares_before_initial_load_upto final_share
    self.last_share_issued_before_initial_load = final_share
    save
  end

  def to_s
  	name
  end

  def self.get
    first_or_create(name: "EDESA")
  end
end
