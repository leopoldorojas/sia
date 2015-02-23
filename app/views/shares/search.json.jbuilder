json.array!(@shares) do |share|
  json.extract! share, :identifier, :value
  json.share_type_identifier share.share_type.identifier
  json.share_holder_name share.share_holder.try(:name)
  json.share_operation_date share.share_operation.try(:operation_date)
  json.url share_url(share, format: :json)
end
