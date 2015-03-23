class Province < Location
  has_many :cities, 	foreign_key: "parent_id"
  belongs_to :country,	foreign_key: "parent_id"

  validates :country, presence: true
end 
