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
    (initial_number_of_shares || 0) + shares.size - shares_operated_since(this_date, "Acquired") + shares_operated_since(this_date, "Endorsed")
  end 

  def shares_operated_since this_date, type
    operation_share_holder = type == "Acquired" ? :share_holder_is : :source_share_holder_is
    total_shares = 0
    ShareOperation.send(operation_share_holder,id).since(this_date).find_each do |share_operation|
      total_shares += (share_operation.shares_required || share_operation.shares_assigned)
    end
    total_shares
  end

  def self.location_in this_location_id
    share_holders_ids = []
    Location.find(this_location_id).location_and_descendants.each { |l| share_holders_ids.concat Location.find(l).share_holders.ids }
    where(id: share_holders_ids)
  end

  def get_shares_to_endorse shares_required, share_type_id
    shares_of_type = get_shares_of_type share_type_id
    shares_required && shares_required > 0 ? shares_of_type.order(:identifier).limit(shares_required) : none
  end

  def get_shares_of_type share_type_id
    shares.joins(:share_issue).where(share_issues: { share_type_id: share_type_id })
  end

  def shares_info
    shares_info_value = ""
    lower_limit = 0
    previous_identifier = nil

    shares.order(:identifier).each_with_index do |share, index|
      unless index == 0
        if share.identifier != previous_identifier + 1
          if lower_limit == 0
            shares_info_value += "#{previous_identifier}, "
          else
            shares_info_value += "#{lower_limit}-#{previous_identifier}, "
            lower_limit = 0
          end
        else
          lower_limit = previous_identifier if lower_limit == 0
        end
      end

      previous_identifier = share.identifier
    end

    shares_info_value += lower_limit == 0 ? "#{previous_identifier}" : "#{lower_limit}-#{previous_identifier}"
  end

end
