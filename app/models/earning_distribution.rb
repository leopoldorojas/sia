class EarningDistribution
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_date, :number_of_months, :actual_number_of_months
  validates :amount_to_distribute, :initial_date, :number_of_months, presence: true

  def matrix
  	# Each cell must contain: ShareHolder´s Number of Shares in that date / Total number of shares in that date / Number of months to calculate
    return false if amount_to_distribute.to_d <=0
  	earnings_distribution_matrix = []
  	earnings_distribution_matrix[0] = []
    list_of_dates = dates 
    self.actual_number_of_months = list_of_dates.length
    return false if actual_number_of_months <= 0    

  	1.upto(actual_number_of_months + 2) do |month|
  		earnings_distribution_matrix[month] = []
  		earnings_distribution_matrix[month][0] = month
  		total_of_shares_this_month = 0
      total_of_value_shares_this_month = 0.0
  		share_holder_index = 1

  		ShareHolder.find_each do |share_holder|
        if month > 1
          previous_month = month - 1

          if previous_month == (actual_number_of_months + 1)
            earnings_for_share_holder_factor = calculate_factor(earnings_distribution_matrix, share_holder_index)
          else 
            last_row = earnings_distribution_matrix[previous_month].length - 1
            shares_of_share_holder_in_previous_month = earnings_distribution_matrix[previous_month][share_holder_index][0]
            total_shares_in_previous_month = earnings_distribution_matrix[previous_month][last_row][0]
            return false if total_shares_in_previous_month <= 0
            earnings_for_share_holder_factor = shares_of_share_holder_in_previous_month.to_f / total_shares_in_previous_month.to_f
          end

          earnings_for_share_holder = earnings_for_share_holder_factor / actual_number_of_months * amount_to_distribute.to_d
          earnings_distribution_matrix[previous_month][share_holder_index][1] = earnings_for_share_holder
          total_of_value_shares_this_month += earnings_for_share_holder
        else 
  			  earnings_distribution_matrix[0][share_holder_index] = share_holder.name
        end

        if month <= actual_number_of_months + 1
          earnings_distribution_matrix[month][share_holder_index] = []
    			shares_in_this_date = (month == (actual_number_of_months + 1)) ? 0 : share_holder.shares_in(list_of_dates[month - 1])
          earnings_distribution_matrix[month][share_holder_index][0] = shares_in_this_date
    			total_of_shares_this_month += shares_in_this_date
        end

        share_holder_index += 1
  		end

      if month <= actual_number_of_months + 1
        earnings_distribution_matrix[month][share_holder_index] = []
        earnings_distribution_matrix[month][share_holder_index][0] = total_of_shares_this_month

        if month > 1
          earnings_distribution_matrix[month - 1][share_holder_index][1] = total_of_value_shares_this_month
        end
      end
  	end

    last_index = earnings_distribution_matrix[actual_number_of_months + 1].length - 1
    earnings_distribution_matrix[actual_number_of_months + 1][last_index] = amount_to_distribute.to_d
  	matrix_by_share_holder earnings_distribution_matrix
  end

  private

    def matrix_by_share_holder matrix
      new_matrix = []
      number_of_share_holders = matrix[0].length - 1
      0.upto(number_of_share_holders) do |share_holder_index|
        new_matrix[share_holder_index] = []
        0.upto(actual_number_of_months) do |month_index|
          new_matrix[share_holder_index][month_index] = matrix[month_index][share_holder_index].is_a?(Array) ? matrix[month_index][share_holder_index][1] : matrix[month_index][share_holder_index]
        end
      end
      new_matrix
    end

    def calculate_factor matrix, row
      total = 0.0

      1.upto(actual_number_of_months) do |month|
        total += matrix[month][row][1]
      end

      total / amount_to_distribute.to_d * actual_number_of_months
    end

    def dates
      date_to_include = initial_date.prev_month 
      list_of_dates = []

      1.upto(number_of_months.to_i) do |month|
        date_to_include = date_to_include.next_month.end_of_month.end_of_day
        if date_to_include <= Time.zone.now.end_of_month.end_of_day
          list_of_dates << date_to_include
        end 
      end

      list_of_dates
    end

end
