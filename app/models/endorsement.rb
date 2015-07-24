class Endorsement < ShareOperation
  validates :source_share_holder, presence: true
  validate :different_share_holders?

  after_create :update_share_holders_equity

  def share_holder= holder
    @share_holder = holder
  end

  def share_holder
    @share_holder ||= (share_holder = ShareHolder.where(id: (share_holder_id.to_i || 0)).try(:first))
  end

  def source_share_holder= holder
    @source_share_holder = holder
  end

  def source_share_holder
    @source_hare_holder ||= (source_share_holder = ShareHolder.where(id: (source_share_holder_id.to_i || 0)).try(:first))
  end

  private

    def shares_finally_assigned
      return shares if shares_assigned == shares_required
      :emitir_nuevas_como_nuevas
      shares + :nuevas
    end

    def new_shares_to_issue= number_of_shares
      @new_shares_to_issue = number_of_shares
    end

    def new_shares_to_issue
      @new_shares_to_issue ||= new_shares_to_issue = 0
    end

    def different_share_holders?
      return if errors.any?
      errors[:base] << I18n.t('endorsement.to_same_share_holder_is_not_allowed') if share_holder == source_share_holder
    end

    def enough_shares?
      return if errors.any?

      # This can be optimized the same way that assign shares to share holder (see below) using an update_all strategy
      self.shares = source_share_holder.get_shares_to_endorse shares_required, share_type_id
      errors[:base] << I18n.t('endorsement.not_enough_shares') unless enough_equity?

    def enough_equity?
      shares_assigned == shares_required || source_share_holder.equity >= total_value
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
      self.source_share_holder.shares_assigned_after_initial_load += new_shares_to_issue
      self.source_share_holder.save
    end

end
