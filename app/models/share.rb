class Share < ActiveRecord::Base
  belongs_to :share_holder
  belongs_to :share_issue
end
