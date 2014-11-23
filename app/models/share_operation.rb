class ShareOperation < ActiveRecord::Base
	attr_accessor :shares_required, :shares_assigned, :share_type_id
  belongs_to :share_holder
  has_one :receipt
  has_many :shares

  validates :share_holder, :shares_required, :share_type_id, presence: true
  validates :shares_required, :numericality => { :greater_than => 0 }
  validate :enough_shares_in_stock?, :operation_consistent?

  def shares_assigned
    @shares_assigned || (self.shares_assigned = shares.size)
  end

  def share_type
    shares.try(:first).try(:share_type)
  end

  def shares_required
     @shares_required.blank? || @shares_required.is_a?(Integer) ? @shares_required : (shares_required = @shares_required.to_i)
  end

  def share_type_id
     @share_type_id.blank? || @share_type_id.is_a?(Integer) ? @share_type_id : (share_type_id = @share_type_id.to_i)
  end

  private

    def enough_shares_in_stock?
    	return if errors.any?
    	self.shares = Share.get_next_shares shares_required, share_type_id
    	errors[:base] << I18n.t('share_operation.not_enough_shares') unless shares_assigned == shares_required
    end

	  def operation_consistent?
	  	return if errors.any?
	  	self.shares_assigned ||= 0
	  	self.cash ||= 0
	  	self.dividends ||= 0
	  	self.adjustment ||= 0
	    errors[:base] << I18n.t('share_operation.invalid_amounts') unless shares_assigned * share_type.value == cash + dividends + adjustment
	  end

end
