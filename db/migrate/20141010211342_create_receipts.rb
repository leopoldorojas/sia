class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :number
      t.string :type
      t.date :receipt_date
      t.text :description
      t.references :share_operation, index: true

      t.timestamps
    end
  end
end
