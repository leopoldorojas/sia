json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :identifier, :shares_info, :share_holder_id, :certificate_date
  json.url certificate_url(certificate, format: :json)
end
