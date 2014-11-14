class ShareHolder < ActiveRecord::Base
  belongs_to :location
  has_many :share_operations
  has_many :shares
end
