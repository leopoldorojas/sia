class ShareHolder < ActiveRecord::Base
  belongs_to :location
  has_many :share_operations
  has_many :shares

  validates :name, presence: true

  def total_owned
    self.shares.map{ |share| share.value }.inject(:+)
  end
end
