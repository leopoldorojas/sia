class RealIssue < ShareIssue

  def update_company
    Company.get.issued_shares_upto final_share
  end

end
