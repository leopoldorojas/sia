json.array!(@share_issues) do |share_issue|
  json.extract! share_issue, :id, :issue_date, :initial_share, :final_share, :company_id
  json.url share_issue_url(share_issue, format: :json)
end
