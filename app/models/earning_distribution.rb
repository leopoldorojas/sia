class EarningDistribution
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_date, :number_of_months
  validates :amount_to_distribute, :initial_date, :number_of_months, presence: true

  def matrix
  	# Each cell must contain: ShareHolder´s Number of Shares in that date / Total number of shares in that date / Number of months to calculate
  	earnings_distribution_matrix = []
  	earnings_distribution_matrix[0] = []

  	1.upto(number_of_months.to_i + 2) do |month|
  		this_date = Time.zone.now
  		earnings_distribution_matrix[month] = []
  		earnings_distribution_matrix[month][0] = month
  		total_of_shares_this_month = 0
      total_of_value_shares_this_month = 0.0
  		share_holder_index = 1

  		ShareHolder.find_each do |share_holder|
        if month > 1
          previous_month = month - 1

          if previous_month == (number_of_months.to_i + 1)
            earnings_for_share_holder_factor = calculate_factor(earnings_distribution_matrix, share_holder_index)
          else 
            last_row = earnings_distribution_matrix[previous_month].length - 1
            shares_of_share_holder_in_previous_month = earnings_distribution_matrix[previous_month][share_holder_index][0]
            total_shares_in_previous_month = earnings_distribution_matrix[previous_month][last_row][0]
            earnings_for_share_holder_factor = shares_of_share_holder_in_previous_month.to_f / total_shares_in_previous_month.to_f
          end

          earnings_for_share_holder = earnings_for_share_holder_factor / number_of_months.to_i * amount_to_distribute.to_d
          earnings_distribution_matrix[previous_month][share_holder_index][1] = earnings_for_share_holder
          total_of_value_shares_this_month += earnings_for_share_holder
        else 
  			  earnings_distribution_matrix[0][share_holder_index] = share_holder.name
        end

        if month <= number_of_months.to_i + 1
          earnings_distribution_matrix[month][share_holder_index] = []
    			shares_in_this_date = (month == (number_of_months.to_i + 1)) ? 0 : share_holder.shares_in(this_date)
          earnings_distribution_matrix[month][share_holder_index][0] = shares_in_this_date
    			total_of_shares_this_month += shares_in_this_date
        end

        share_holder_index += 1
  		end

      if month <= number_of_months.to_i + 1
        earnings_distribution_matrix[month][share_holder_index] = []
        earnings_distribution_matrix[month][share_holder_index][0] = total_of_shares_this_month

        if month > 1
          earnings_distribution_matrix[month - 1][share_holder_index][1] = total_of_value_shares_this_month
        end
      end
  	end

    last_index = earnings_distribution_matrix[number_of_months.to_i + 1].length - 1
    earnings_distribution_matrix[number_of_months.to_i + 1][last_index] = amount_to_distribute.to_d
  	earnings_distribution_matrix
  end

  private

    def calculate_factor matrix, row
      total = 0.0

      1.upto(number_of_months.to_i) do |month|
        total += matrix[month][row][1]
      end

      total / amount_to_distribute.to_d * number_of_months.to_i
    end

end
