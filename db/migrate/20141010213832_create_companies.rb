class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :last_share_issued

      t.timestamps
    end
  end
end
