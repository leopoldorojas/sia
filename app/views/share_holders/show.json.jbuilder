json.extract! @share_holder, :id, :name, :identifier, :contact, :phone, :email, :location_id, :created_at, :updated_at
json.url share_holder_url(@share_holder, format: :json)
