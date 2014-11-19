json.array!(@share_operations) do |share_operation|
  json.extract! share_operation, :id, :operation_date, :share_holder_id, :shares_assigned, :cash, :dividends, :adjustment
  json.url share_operation_url(share_operation, format: :json)
end
