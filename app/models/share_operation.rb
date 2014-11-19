class ShareOperation < ActiveRecord::Base
	attr_accessor :shares_required, :shares_assigned
  belongs_to :share_holder
  has_one :receipt
  has_many :shares

  validates :share_holder, presence: true
  validates :shares_required, presence: true
  validates :shares_required, :numericality => { :greater_than => 0 }
  validate :shares_to_sell?, :operation_consistency

  private

    def shares_to_sell?
    	return unless errors.blank?
    	self.shares, self.shares_assigned = Share.get_next_shares(shares_required.to_i)
    	errors[:base].push(I18n.t('share_operation.not_enough_shares')) unless shares_assigned == shares_required
    end

	  def operation_consistency
	  	return unless errors.blank?
	  	share_value = shares.first.share_issue.company.share_type.value
	  	self.shares_assigned ||= 0
	  	self.cash ||= 0
	  	self.dividends ||= 0
	  	self.adjustment ||= 0
	    errors[:base] << I18n.t('share_operation.invalid_amounts') unless shares_assigned * share_value == cash + dividends + adjustment
	  end

	  def share_assigned
	  	@shares_assigned ||= shares.count
	  end

end
