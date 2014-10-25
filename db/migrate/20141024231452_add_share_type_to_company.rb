class AddShareTypeToCompany < ActiveRecord::Migration
  def change
    add_reference :companies, :share_type, index: true
  end
end
