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

# First, load the Big Fleets assigning them the Source created above
# Also, we need create the corresponding Companies. One company for each Big Fleet
CSV.foreach(Rails.root.join("db/control_de_socios_seed.csv")) do |share_holder|
  name, equity, earnings, stock_prepaid = share_holder
  ShareHolder.create do |sh|
  	sh.name = name
  	sh.equity = equity.is_a?(String) ? equity.gsub(',','').to_f : equity
  	sh.earnings = earnings.is_a?(String) ? earnings.gsub(',','').to_f : earnings
  	sh.stock_prepaid = stock_prepaid.is_a?(String) ? stock_prepaid.gsub(',','').to_f : stock_prepaid
  end
end
