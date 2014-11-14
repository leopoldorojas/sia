class ShareType < ActiveRecord::Base
	has_many :shares
	belongs_to :company
end
