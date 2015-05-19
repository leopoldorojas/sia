require 'csv'

namespace :initial_load do
  desc "Initial Loading of Number of Shares when the system starts in its first release"
  task number_of_shares: :environment do
    share_value = 50000.00

		CSV.foreach(Rails.root.join("db/control_de_socios_seed.csv")) do |share_holder|
		  name, equity, earnings, stock_prepaid = share_holder

      if sh = ShareHolder.where(name: name).first
      	equity = equity.is_a?(String) ? equity.gsub(',','').to_f : equity
      	sh.initial_number_of_shares = equity / share_value
        sh.save
      end

		end
  end
end
