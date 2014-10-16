class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  belongs_to :share_type
end
