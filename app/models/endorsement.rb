class Endorsement < ShareOperation
  attr_accessor :share_holder

  before_validation :set_share_holder

  validates :source_share_holder_id, presence: true

  private

    def set_share_holder
      self.share_holder = ShareHolder.where(id: (share_holder_id.to_i || 0)).first
    end

    def enough_shares?
      return if errors.any?

      # This can be optimized the same way that assign shares to share holder (see below) using an update_all strategy
      self.shares = Share.endorse source_share_holder_id, share_holder.id, shares_required, share_type_id 
      errors[:base] << I18n.t('endorsement.not_enough_shares') unless shares_assigned == shares_required
    end

end
