class Sale < ShareOperation
	attr_accessor :shares_required, :shares_assigned, :share_type_id
  belongs_to :share_holder

  validates :share_holder, :shares_required, :share_type_id, presence: true
  validates :shares_required, :numericality => { :greater_than => 0 }
  validate :enough_earnings?, if: :will_use_dividends?
  validate :enough_stock_prepaid?, if: :will_use_adjustment?
  validate :enough_shares_in_stock?, :operation_consistent?

  before_save :assign_shares_to_share_holder
  after_create :update_share_holder

  class << self
    def share_holder_is this_share_holder_id
      joins(:share_holder).where(share_holders: {id: this_share_holder_id})
    end
  end

  def shares_assigned
    @shares_assigned || (self.shares_assigned = shares.size)
  end

  def shares_required
     @shares_required.blank? || @shares_required.is_a?(Integer) ? @shares_required : (shares_required = @shares_required.to_i)
  end

  def share_type_id
     @share_type_id.blank? || @share_type_id.is_a?(Integer) ? @share_type_id : (share_type_id = @share_type_id.to_i)
  end

  def total_value
    shares_assigned * share_type.value
  end

  private

    def will_use_dividends?
      dividends.present?
    end

    def will_use_adjustment?
      adjustment.present?
    end

    def enough_earnings?
      return if errors.any?
      errors[:base] << I18n.t('share_operation.not_enough_earnings') if new_share_holder_earnings < 0
    end

    def enough_stock_prepaid?
      return if errors.any?
      errors[:base] << I18n.t('share_operation.not_enough_stock_prepaid') if new_share_holder_stock_prepaid < 0
    end

    def enough_shares_in_stock?
    	return if errors.any?

      # This can be optimized the same way that assign shares to share holder (see below) using an update_all strategy
    	self.shares = Share.get_next_shares shares_required, share_type_id 

    	errors[:base] << I18n.t('share_operation.not_enough_shares') unless shares_assigned == shares_required
    end

	  def operation_consistent?
	  	return if errors.any?
	  	self.shares_assigned ||= 0
	  	self.cash ||= 0
	  	self.dividends ||= 0
	  	self.adjustment ||= 0
	    errors[:base] << I18n.t('share_operation.invalid_amounts') unless total_value == cash + dividends + adjustment
	  end

    def assign_shares_to_share_holder
      Share.assign_shares_to(share_holder, shares)
    end

    def new_share_holder_equity
      share_holder.equity.respond_to?(:+) ? share_holder.equity + total_value : total_value
    end

    def new_share_holder_earnings
      share_holder.earnings.respond_to?(:-) ? share_holder.earnings - dividends : -dividends
    end

    def new_share_holder_stock_prepaid
      share_holder.stock_prepaid.respond_to?(:-) ? share_holder.stock_prepaid - adjustment : -adjustment
    end

    def update_share_holder
      self.share_holder.equity = new_share_holder_equity
      self.share_holder.earnings = new_share_holder_earnings
      self.share_holder.stock_prepaid = new_share_holder_stock_prepaid
      self.share_holder.save
    end
end
