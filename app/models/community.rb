class Community < Location
  belongs_to :district,	foreign_key: "parent_id"
  validates :district, presence: true
end
