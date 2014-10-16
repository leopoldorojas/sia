class ShareHolder < ActiveRecord::Base
  belongs_to :location
  has_many :shares
  has_many :share_operations
end
