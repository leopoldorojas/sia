class City < Location
  has_many :districts,	foreign_key: "parent_id"
  belongs_to :province, foreign_key: "parent_id"

  validates :province, presence: true
end
