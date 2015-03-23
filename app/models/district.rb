class District < Location
  has_many :communities,	foreign_key: "parent_id"
  belongs_to :city,	foreign_key: "parent_id"
  
  validates :city, presence: true
end
