class ShareType < ActiveRecord::Base
	has_many :share_issues
	belongs_to :company

	validates :identifier, :value, presence: :true

	def to_s
		"#{identifier} (#{value})"
	end
end
