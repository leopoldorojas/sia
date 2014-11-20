class AddShareTypeToShareOperation < ActiveRecord::Migration
  def change
    add_reference :share_operations, :share_type, index: true
  end
end
