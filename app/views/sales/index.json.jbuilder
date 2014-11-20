json.array!(@share_operations) do |share_operation|
  json.extract! share_operation, :id, :operation_date, :share_holder, :shares_assigned, :share_type
  json.cash share_operation.cash.to_f
  json.dividends share_operation.dividends.to_f
  json.adjustment share_operation.adjustment.to_f
  json.url share_operation_url(share_operation, format: :json)
end
