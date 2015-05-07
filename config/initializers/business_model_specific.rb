Rails.application.configure do

  #Configure Maximum Shares to issue at once in order to protect the performance of SQL Insert query
  config.maximum_shares_to_issue_at_once = 1000

  #Configure Default Initial Date for Earnings Distribution. This might be has to do with date on the beginning of fiscal year
  config.distribution_initial_date = Time.zone.local(Time.zone.now.year,10,1)
end