class AddLastShareIssuedBeforeInitialLoadToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :last_share_issued_before_initial_load, :integer
  end
end
