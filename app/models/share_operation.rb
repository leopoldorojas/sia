class ShareOperation < ActiveRecord::Base
  belongs_to :share_holder
  has_many :receipts
  has_many :shares
end
