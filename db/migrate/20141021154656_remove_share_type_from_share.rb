class RemoveShareTypeFromShare < ActiveRecord::Migration
  def change
  	remove_column :shares, :share_type, :string
  	remove_column :shares, :share_type_id, :integer
  end
end
