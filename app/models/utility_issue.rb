class UtilityIssue < ShareIssue

  def self.emit number_of_shares share_type
    return [] if number_of_shares == 0

    utility_issue = create do |u|
      u.issue_date = Time.zone.now 
      u.initial_share = Company.get.issued_shares_before_initial_load_upto + 1
      u.final_share = u.initial_share + number_of_shares
      u.share_type = share_type
    end

    utility_issue.shares
  end

  def update_company
    Company.get.issued_shares_before_initial_load_upto final_share
  end

end