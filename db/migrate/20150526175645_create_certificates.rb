class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :identifier
      t.string :shares_info
      t.references :share_holder, index: true
      t.date :certificate_date

      t.timestamps
    end
  end
end
