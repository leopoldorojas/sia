class RemoveCompanyIdFromShareIssue < ActiveRecord::Migration
  def change
    remove_reference :share_issues, :company, index: true
  end
end
