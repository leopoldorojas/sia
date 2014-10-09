json.array!(@locations) do |location|
  json.extract! location, :id, :name, :type, :parent_id
  json.url location_url(location, format: :json)
end
