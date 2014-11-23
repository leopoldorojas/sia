class ShareType < ActiveRecord::Base
	has_many :share_issues
	belongs_to :company
end
