class RemoveShareTypeIdFromCompanies < ActiveRecord::Migration
  def change
    remove_reference :companies, :share_type, index: true
  end
end
