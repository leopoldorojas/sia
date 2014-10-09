class CreateShareOperations < ActiveRecord::Migration
  def change
    create_table :share_operations do |t|
      t.Date :operation_date
      t.references :share_holder, index: true
      t.integer :shares_number
      t.decimal :cash
      t.decimal :dividends
      t.decimal :adjustment

      t.timestamps
    end
  end
end
