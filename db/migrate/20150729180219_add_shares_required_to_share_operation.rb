class AddSharesRequiredToShareOperation < ActiveRecord::Migration
  def change
    add_column :share_operations, :shares_required, :integer
  end
end
