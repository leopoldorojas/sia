class Receipt < ActiveRecord::Base
  belongs_to :share_operation

  default_scope { order :number }

  def to_s
  	number
  end
end
