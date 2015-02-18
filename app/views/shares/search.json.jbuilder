json.array!(@shares) do |share|
  json.extract! share, :identifier, :share_type_identifier, :share_value, :share_holder_name, share_operation_date
  json.url share_url(share, format: :json)
end
