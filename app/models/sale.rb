class Sale < ShareOperation
  belongs_to :share_holder

  before_save :assign_shares_to_share_holder
  after_create :update_share_holder

  class << self
    def share_holder_is this_share_holder_id
      joins(:share_holder).where(share_holders: {id: this_share_holder_id})
    end
  end

  private

    def enough_shares?
      return if errors.any?

      # This can be optimized the same way that assign shares to share holder (see below) using an update_all strategy
      self.shares = Share.get_next_shares shares_required, share_type_id 
      errors[:base] << I18n.t('share_operation.not_enough_shares') unless shares_assigned == shares_required
    end

    def assign_shares_to_share_holder
      Share.assign_shares_to(share_holder, shares)
    end

    def new_share_holder_equity
      share_holder.equity.respond_to?(:+) ? share_holder.equity + total_value : total_value
    end

    def update_share_holder
      self.share_holder.equity = new_share_holder_equity
      self.share_holder.earnings = new_share_holder_earnings
      self.share_holder.stock_prepaid = new_share_holder_stock_prepaid
      self.share_holder.save
    end
end
