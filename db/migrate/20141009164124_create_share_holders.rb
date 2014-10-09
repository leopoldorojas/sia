class CreateShareHolders < ActiveRecord::Migration
  def change
    create_table :share_holders do |t|
      t.string :name
      t.string :identifier
      t.string :contact
      t.string :phone
      t.string :email
      t.references :location, index: true

      t.timestamps
    end
  end
end
