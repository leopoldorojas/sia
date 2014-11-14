class RenameColumnNameInShareTypeToIdentifier < ActiveRecord::Migration
  def change
		change_table :share_types do |t|
		  t.rename :name, :identifier
		end
  end
end
