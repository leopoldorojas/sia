class ChangeColumnTypeInShare < ActiveRecord::Migration
	change_table :shares do |t|
	  t.rename :type, :share_type
	end
end
