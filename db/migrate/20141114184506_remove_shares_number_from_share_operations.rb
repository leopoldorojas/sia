class RemoveSharesNumberFromShareOperations < ActiveRecord::Migration
  def change
    remove_column :share_operations, :shares_number, :integer
  end
end
