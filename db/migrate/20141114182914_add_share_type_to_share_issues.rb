class AddShareTypeToShareIssues < ActiveRecord::Migration
  def change
    add_reference :share_issues, :share_type, index: true
  end
end
