class Endorsement < ShareOperation
  attr_accessor :share_holder, :source_share_holder

  before_validation :set_share_holders

  validates :source_share_holder, presence: true

  before_save :assign_shares_to_share_holder
  after_create :update_share_holders_equity

  private

    def set_share_holders
      self.share_holder = ShareHolder.where(id: (share_holder_id.to_i || 0)).first
      self.source_share_holder = ShareHolder.where(id: (source_share_holder_id.to_i || 0)).first
    end

    def enough_shares?
      return if errors.any?

      # This can be optimized the same way that assign shares to share holder (see below) using an update_all strategy
      self.shares = source_share_holder.get_shares_to_endorse shares_required, share_type_id
      errors[:base] << I18n.t('endorsement.not_enough_shares') unless shares_assigned == shares_required
    end

    def new_source_share_holder_equity
      source_share_holder.equity.respond_to?(:-) ? source_share_holder.equity - total_value : -total_value
    end

    def update_share_holders_equity
      update_target_share_holder if update_source_share_holder
    end

    def update_target_share_holder
      self.share_holder.equity = new_share_holder_equity
      self.share_holder.save
    end

    def update_source_share_holder
      self.source_share_holder.equity = new_source_share_holder_equity
      self.source_share_holder.save
    end

end
