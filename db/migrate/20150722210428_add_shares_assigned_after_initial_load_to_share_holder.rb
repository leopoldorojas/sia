class AddSharesAssignedAfterInitialLoadToShareHolder < ActiveRecord::Migration
  def change
  	add_column :share_holders, :shares_assigned_after_initial_load, :integer
  end
end
