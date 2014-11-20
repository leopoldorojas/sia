class RemoveValueFromShare < ActiveRecord::Migration
  def change
    remove_column :shares, :value, :decimal
  end
end
