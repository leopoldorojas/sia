json.array!(@share_issues) do |share_issue|
  json.extract! share_issue, :id, :issue_date, :initial_share, :final_share, :created_at, :updated_at
  json.share_type_identifier share_issue.share_type.identifier
end
