# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

company = Company.create do |c|
	c.name = "EDESA"
end

ShareType.create do |st|
	st.identifier="A"
	st.value = 50000.00
	st.company = company
end

User.create do |u|
	u.email = "leopoldo.rojas@arckanto.com"
	u.password = "facil1234"
  u.name = "Leopoldo Rojas Moguel"
  u.approved = true
  u.company = company
  u.role = "superadmin"
end

CSV.foreach(Rails.root.join("db/control_de_socios_seed.csv")) do |share_holder|
  name, equity, earnings, stock_prepaid = share_holder
  ShareHolder.create do |sh|
  	sh.name = name
  	sh.equity = equity.is_a?(String) ? equity.gsub(',','').to_f : equity
  	sh.earnings = earnings.is_a?(String) ? earnings.gsub(',','').to_f : earnings
  	sh.stock_prepaid = stock_prepaid.is_a?(String) ? stock_prepaid.gsub(',','').to_f : stock_prepaid
  end
end
