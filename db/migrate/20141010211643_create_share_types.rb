class CreateShareTypes < ActiveRecord::Migration
  def change
    create_table :share_types do |t|
      t.string :name
      t.decimal :value

      t.timestamps
    end
  end
end
