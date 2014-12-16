class AddBalancesToShareHolders < ActiveRecord::Migration
  def change
    add_column :share_holders, :equity, :decimal
    add_column :share_holders, :earnings, :decimal
    add_column :share_holders, :stock_prepaid, :decimal
  end
end
