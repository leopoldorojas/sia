class EarningDistribution
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_date, :number_of_months
  validates :amount_to_distribute, :initial_date, :number_of_months, presence: true

  def matrix
  	# Each cell must contain: ShareHolder´s Number of Shares in that date / Total number of shares in that date / Number of months to calculate
  	number_of_shares_matrix = []
  	number_of_shares_matrix[0] = []

  	1.upto(number_of_months.to_i) do |month|
  		this_date = Time.zone.now
  		number_of_shares_matrix[month] = []
  		number_of_shares_matrix[month][0] = month
  		total_of_shares_this_month = 0
  		share_holder_index = 1

  		ShareHolder.find_each do |share_holder|
  			number_of_shares_matrix[0][share_holder_index] = share_holder.name if month == 1
  			shares_in_this_date = number_of_shares_matrix[month][share_holder_index] = share_holder.shares_in(this_date)
  			share_holder_index += 1
  			total_of_shares_this_month += shares_in_this_date
  		end

      number_of_shares_matrix[month][share_holder_index] = total_of_shares_this_month
  	end
    #OJOOOoOOOOOOOO RECORRRER la columna dos, calculando los montos en la columna 1 en una tercera dimension...!! Para no recorrerla tantas vaces
  	number_of_shares_matrix
  end

end
