class AddValueToShares < ActiveRecord::Migration
  def change
    add_column :shares, :value, :decimal
  end
end
