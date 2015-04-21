class EarningDistribution
  include ActiveModel::Model

  attr_accessor :amount_to_distribute, :initial_month, :end_month, :results
  validates :amount_to_distribute, :initial_month, :end_month, presence: true

  def run
    self.results = ResultMatrix.new(amount_to_distribute: amount_to_distribute, initial_month: initial_month, end_month: end_month).results
  end
end
