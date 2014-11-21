class RemoveShareTypeIdFromShareOperation < ActiveRecord::Migration
  def change
    remove_reference :share_operations, :share_type, index: true
  end
end
