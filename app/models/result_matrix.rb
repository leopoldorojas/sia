class ResultMatrix
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_month, :end_month

  def results
    ShareHolder.all
  end

end
