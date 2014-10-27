class ShareOperation < ActiveRecord::Base
	attr_accessor :shares_count
  belongs_to :share_holder
  has_many :receipts
  has_many :shares

  before_validation :assign_shares
  validates :shares_number, presence: true
  validates :shares_number, :numericality => { :greater_than => 0 }
  validate :shares_to_sell?, :operation_consistency

  private

	  def assign_shares
	  	self.shares, self.shares_count = Share.get_next_shares(shares_number)
	  end

    def shares_to_sell?
    	return unless errors.blank?
    	errors[:base].push(I18n.t('share_operation.not_enough_shares')) unless shares_count == shares_number
    end

	  def operation_consistency
	  	return unless errors.blank?
	  	share_value = shares.first.share_issue.company.share_type.value
	  	self.shares_number ||= 0
	  	self.cash ||= 0
	  	self.dividends ||= 0
	  	self.adjustment ||= 0
	    errors[:base] << I18n.t('share_operation.invalid_amounts') unless shares_number * share_value == cash + dividends + adjustment
	  end

end
