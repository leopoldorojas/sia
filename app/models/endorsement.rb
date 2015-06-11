class Endorsement < ShareOperation
  validates :source_share_holder_id, presence: true
end
