class AddCompanyToShareType < ActiveRecord::Migration
  def change
    add_reference :share_types, :company, index: true
  end
end
