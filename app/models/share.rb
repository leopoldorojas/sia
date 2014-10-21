class Share < ActiveRecord::Base
  belongs_to :share_operation
  belongs_to :share_issue
  delegate :share_type, to: :share_issue
end
