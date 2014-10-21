class ChangeColumnTypeInShareIssue < ActiveRecord::Migration
	change_table :share_issues do |t|
	  t.rename :type, :share_type
	end
end
