class ShareHolder < ActiveRecord::Base
  belongs_to :location
  has_many :share_operations
  has_many :shares

  validates :name, presence: true
  default_scope { order(:name) }

  # This method could be deprected because the total_owned need to take into account the balanca of the initial load
  def total_owned
    self.shares.map{ |share| share.value }.inject(:+)
  end

  def to_s
  	name
  end

  # Calculate how many shares the share holder had in an initial date plus a number specific of months
  def shares_in this_date
    (initial_number_of_shares || 0) + shares.size - shares_acquired_since(this_date) + shares_left_since(this_date)
  end 

  def shares_left_since this_date
    0
  end

  def shares_acquired_since this_date
    total_shares = 0
    Sale.share_holder_is(id).since(this_date).find_each { |sale| total_shares += sale.shares.size }
    total_shares
  end

  def self.location_in this_location_id
    share_holders_ids = []
    Location.find(this_location_id).location_and_descendants.each { |l| share_holders_ids.concat Location.find(l).share_holders.ids }
    where(id: share_holders_ids)
  end
end
