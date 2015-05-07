class ResultMatrix
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_date, :number_of_months

  def results
    ShareHolder.all
  end

end
