class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :approved, :boolean
    add_reference :users, :company, index: true
    add_column :users, :role, :string
  end
end
