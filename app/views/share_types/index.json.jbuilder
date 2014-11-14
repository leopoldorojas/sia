json.array!(@share_types) do |share_type|
  json.extract! share_type, :id, :identifier, :value
  json.url share_type_url(share_type, format: :json)
end
