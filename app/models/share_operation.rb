class ShareOperation < ActiveRecord::Base
  attr_accessor :shares_required

  validates :share_holder, :shares_required, presence: true
  validates :shares_required, :numericality => { :greater_than => 0 }
  validate :enough_earnings?, if: :will_use_dividends?
  validate :enough_stock_prepaid?, if: :will_use_adjustment?
  validate :enough_shares?, :operation_consistent?

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
  end

  def shares_required
     @shares_required.blank? || @shares_required.is_a?(Integer) ? @shares_required : (shares_required = @shares_required.to_i)
  end

  def share_type
    shares.try(:first).try(:share_type)
  end

  def total_value
    shares_required * share_type.value
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
      please_raise error because must be implemented by a child
    end

    def new_share_holder_earnings
      share_holder.earnings.respond_to?(:-) ? share_holder.earnings - dividends : -dividends
    end

    def new_share_holder_stock_prepaid
      share_holder.stock_prepaid.respond_to?(:-) ? share_holder.stock_prepaid - adjustment : -adjustment
    end

    def operation_consistent?
      return if errors.any?
      self.cash ||= 0
      self.dividends ||= 0
      self.adjustment ||= 0
      errors[:base] << I18n.t('share_operation.invalid_amounts') unless total_value == cash + dividends + adjustment
    end
end
