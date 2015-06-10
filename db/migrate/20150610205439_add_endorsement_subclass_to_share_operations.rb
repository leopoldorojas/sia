class AddEndorsementSubclassToShareOperations < ActiveRecord::Migration
  def change
  	add_column :share_operations, :source_share_holder_id, :integer
    add_column :share_operations, :type, :string
  end
end
