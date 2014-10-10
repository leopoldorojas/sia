json.array!(@companies) do |company|
  json.extract! company, :id, :name, :last_share_issued
  json.url company_url(company, format: :json)
end
