json.array!(@shares) do |share|
  json.extract! share, :id, :number, :share_holder_id, :share_issue_id
  json.url share_url(share, format: :json)
end
