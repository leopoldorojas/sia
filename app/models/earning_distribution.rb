class EarningDistribution
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_date, :number_of_months, :results
  validates :amount_to_distribute, :initial_date, :number_of_months, presence: true

  def run
    self.results = ResultMatrix.new(amount_to_distribute: amount_to_distribute, initial_date: initial_date, number_of_months: number_of_months).results
  end
end
