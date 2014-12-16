class Receipt < ActiveRecord::Base
  belongs_to :share_operation

  def to_s
  	number
  end
end
