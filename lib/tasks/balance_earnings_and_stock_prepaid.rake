namespace :balance_earnings_and_stock_prepaid do
	desc "Balance the information of Earnings and Stock Prepaid in order to not have negative earnings"

	task balance: :environment do
    ShareHolder.where("earnings < 0").find_each do |share_holder|
    	if share_holder.stock_prepaid + share_holder.earnings > 0
        share_holder.stock_prepaid += share_holder.earnings
        share_holder.earnings = 0
        share_holder.save
    	end
    end
	end
end
