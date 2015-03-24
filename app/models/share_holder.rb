class ShareHolder < ActiveRecord::Base
  belongs_to :location
  has_many :share_operations
  has_many :shares

  validates :name, presence: true
  default_scope { order(:name) }

  def total_owned
    self.shares.map{ |share| share.value }.inject(:+)
  end

  def to_s
  	name
  end

  def self.location_in this_location_id
    share_holders_ids = []
    Location.find(this_location_id).location_and_descendants.each { |l| share_holders_ids.concat Location.find(l).share_holders.ids }
    where(id: share_holders_ids)
  end
end
