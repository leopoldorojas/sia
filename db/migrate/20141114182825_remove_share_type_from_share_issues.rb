class RemoveShareTypeFromShareIssues < ActiveRecord::Migration
  def change
    remove_column :share_issues, :share_type, :string
  end
end
