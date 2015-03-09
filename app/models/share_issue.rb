class ShareIssue < ActiveRecord::Base
  has_many :shares 
  belongs_to :share_type
  delegate :company, to: :share_type

  validates :share_type_id, presence: true

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
    	elsif start_present? && finish.blank?
    		query_string = "final_share >= :start"
    	elsif start.blank? && finish.present?
    		query_string = "initial_share <= :finish"
    	end

      where(query_string, {start: start, finish: finish})
    end
  end
end
