class Country < Location
  has_many :provinces, foreign_key: "parent_id"
end