class ShareIssue < ActiveRecord::Base
  has_many :shares 
  belongs_to :share_type
  delegate :company, to: :share_type

  validates :share_type_id, presence: true
end
