json.array!(@receipts) do |receipt|
  json.extract! receipt, :id, :number, :type, :receipt_date, :description, :share_operation_id
  json.url receipt_url(receipt, format: :json)
end
