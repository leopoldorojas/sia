class CreateShareIssues < ActiveRecord::Migration
  def change
    create_table :share_issues do |t|
      t.date :issue_date
      t.integer :initial_share
      t.integer :final_share
      t.references :company, index: true

      t.timestamps
    end
  end
end
