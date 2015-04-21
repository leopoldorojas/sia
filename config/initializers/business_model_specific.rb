#Configure Maximum Shares to issue at once in order to protect the performance of SQL Insert query
Rails.application.config.maximum_shares_to_issue_at_once = 1000
