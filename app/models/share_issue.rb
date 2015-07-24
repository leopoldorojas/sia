class ShareIssue < ActiveRecord::Base
  has_many :shares 
  belongs_to :share_type
  delegate :company, to: :share_type

  validates :issue_date, :final_share, :share_type_id, presence: true
  validate :share_range, :maximum_shares_to_issue

  before_save :create_shares
  after_save :update_company

  default_scope { order issue_date: :desc }

  class << self
    def since this_date
      where("issue_date >= ?", this_date)
    end

    def until this_date
      where("issue_date <= ?", this_date)
    end

    def between start, finish

    	if start.present? && finish.present?
    		query_string = "(initial_share >= :start and initial_share <= :finish) or (final_share >= :start and final_share <= :finish)"
    	elsif start.present? && finish.blank?
    		query_string = "final_share >= :start"
    	elsif start.blank? && finish.present?
    		query_string = "initial_share <= :finish"
    	end

      where(query_string, {start: start, finish: finish})
    end
  end

  private

    def update_company
      return true   # This method should be implemented as a child level: RealIssue or UtilityIssue
    end

    def create_shares
      initial_share.upto(final_share) { |identifier| shares.build(identifier: identifier) }    
    end

    def share_range
      return if errors.any?
      errors[:base] << I18n.t('issuance.invalid_share_range') if final_share.blank? || initial_share > final_share
    end

    def maximum_shares_to_issue
      return if errors.any?
      maximum = Rails.application.config.maximum_shares_to_issue_at_once
      errors[:base] << I18n.t('issuance.a_lot_of_shares_to_issue', maximum: maximum) if final_share - initial_share > maximum
    end
end
