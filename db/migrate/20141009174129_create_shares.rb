class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :number
      t.string :type
      t.references :share_holder, index: true
      t.references :share_issue, index: true

      t.timestamps
    end
  end
end
