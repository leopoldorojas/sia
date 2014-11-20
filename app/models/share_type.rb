class ShareType < ActiveRecord::Base
	has_many :shares
	has_many :share_operations
	belongs_to :company
end
