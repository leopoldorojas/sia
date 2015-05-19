class AddInitialLoadingFieldsToShareHolder < ActiveRecord::Migration
  def change
    add_column :share_holders, :initial_number_of_shares, :integer
  end
end
