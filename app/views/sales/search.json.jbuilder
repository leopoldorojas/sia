json.array!(@sales) do |sale|
  json.extract! sale, :id, :operation_date, :share_holder, :shares_assigned
  json.cash sale.cash.to_f
  json.dividends sale.dividends.to_f
  json.adjustment sale.adjustment.to_f
  json.receipt sale.receipt.to_s
  json.url sale_url(sale, format: :json)
end
