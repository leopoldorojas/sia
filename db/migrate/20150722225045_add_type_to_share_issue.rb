class AddTypeToShareIssue < ActiveRecord::Migration
  def change
  	add_column :share_issues, :type, :string
  end
end
