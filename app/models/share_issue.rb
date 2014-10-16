class ShareIssue < ActiveRecord::Base
  belongs_to :company
  has_many :shares
end
