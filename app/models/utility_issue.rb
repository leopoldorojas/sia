class UtilityIssue < ShareIssue

  def update_company
    Company.get.issued_shares_before_initial_load_add :nuevas_size
  end

end