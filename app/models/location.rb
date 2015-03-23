class Location < ActiveRecord::Base
	has_many :share_holders
  validates :name, :type, presence: true

  def self.types
    ['Country', 'Province', 'City', 'District', 'Community']
  end
  
  def to_s
    name
  end

  def parent_model
  	Location.types.each { |t| return t if self.respond_to? t.underscore.to_sym }
  	nil
  end

  def location_and_descendants
    @@locations = []
    parse_location_tree
    @@locations
  end

  def parse_location_tree
    @@locations << self
    Location.where(parent_id: id).each { |l| l.parse_location_tree }
  end

end