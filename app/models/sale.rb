class Sale < ShareOperation
  validates :receipt, presence: true
  validate :operation_consistent?
  belongs_to :share_holder

  before_save :assign_shares_to_share_holder
  after_create :update_share_holder

  private

    def enough_shares?
      return if errors.any?

      # This can be optimized the same way that assign shares to share holder (see below) using an update_all strategy
      self.shares = Share.get_next_shares shares_required, share_type_id 
      errors[:base] << I18n.t('share_operation.not_enough_shares') unless shares_assigned == shares_required
    end

    def update_share_holder
      self.share_holder.equity = new_share_holder_equity
      self.share_holder.earnings = new_share_holder_earnings
      self.share_holder.stock_prepaid = new_share_holder_stock_prepaid
      self.share_holder.save
    end

    def operation_consistent?
      return if errors.any?
      self.cash ||= 0
      self.dividends ||= 0
      self.adjustment ||= 0
      errors[:base] << I18n.t('share_operation.invalid_amounts') unless total_value == cash + dividends + adjustment
    end
end
