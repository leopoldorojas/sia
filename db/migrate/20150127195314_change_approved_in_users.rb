class ChangeApprovedInUsers < ActiveRecord::Migration
  def change
		change_column_null :users, :approved, false
		change_column_default :users, :approved, false
  end
end
