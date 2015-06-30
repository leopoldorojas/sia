json.array!(@endorsements) do |endorsement|
  json.extract! endorsement, :id, :operation_date, :source_share_holder, :share_holder, :shares_assigned, :share_type
  json.receipt endorsement.receipt.to_s
  json.url endorsement_url(endorsement, format: :json)
end