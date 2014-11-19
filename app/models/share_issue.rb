class ShareIssue < ActiveRecord::Base
  belongs_to :company
  belongs_to :share_type
  has_many :shares

  validates :share_type_id, presence: true
end
