class ShareOperation < ActiveRecord::Base
  attr_accessor :shares_required, :share_type_id, :shares_assigned

  validates :share_holder, :shares_required, :share_type_id, :receipt, presence: true
  validates :shares_required, :numericality => { :greater_than => 0 }
  validate :enough_earnings?, if: :will_use_dividends?
  validate :enough_stock_prepaid?, if: :will_use_adjustment?
  validate :enough_shares?

  before_save :assign_shares_to_share_holder
  
  has_one :receipt
  has_many :shares
  default_scope { order operation_date: :desc }

  class << self
    def since this_date
      where("operation_date >= ?", this_date)
    end

    def until this_date
      where("operation_date <= ?", this_date)
    end

    def receipt_like this_receipt
      joins(:receipt).where("upper(receipts.number) LIKE upper(?)", "%#{this_receipt}%")
    end

    def share_holder_is this_share_holder_id
      where("share_holder_id = ?", this_share_holder_id)
    end

    def source_share_holder_is this_share_holder_id
      where("source_share_holder_id = ?", this_share_holder_id)
    end

  end

  def shares_required
     @shares_required.blank? || @shares_required.is_a?(Integer) ? @shares_required : (shares_required = @shares_required.to_i)
  end

  def share_type_id
     @share_type_id.blank? || @share_type_id.is_a?(Integer) ? @share_type_id : (share_type_id = @share_type_id.to_i)
  end

  def share_type
    ShareType.where(id: share_type_id).first
  end

  def total_value
    shares_required * (share_type.try(:value) || 0)
  end

  def shares_assigned
    @shares_assigned || (self.shares_assigned = shares.size)
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

    def enough_shares?
      return if errors.any?
      raise "An error ocurred: Method 'enough_shares?' must be implemented in a Share Operation subclass"
    end

    def assign_shares_to_share_holder
      Share.assign_shares_to share_holder, shares + UtilityIssue.emit(shares_required - shares_assigned, share_type)
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
end
