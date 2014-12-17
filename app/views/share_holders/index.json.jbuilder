json.array!(@share_holders) do |share_holder|
  json.extract! share_holder, :id, :name, :identifier, :contact, :phone, :email, :location_id, :equity, :earnings, :stock_prepaid
  json.url share_holder_url share_holder
end
