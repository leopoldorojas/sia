class ShareType < ActiveRecord::Base
	has_many :shares
	has_many :companies		# A ShareType could have many companies as its default share type
end
