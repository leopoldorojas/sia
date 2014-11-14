class ChangesToShares < ActiveRecord::Migration
  def change
		change_table :shares do |t|
		  t.references :share_holder
		  t.rename :number, :identifier
		end
  end
end
