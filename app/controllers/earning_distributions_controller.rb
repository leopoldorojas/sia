class EarningDistributionsController < ApplicationController
  before_action :authorize_for_managing
  
  def new
    initial_date = Rails.application.config.distribution_initial_date
    today = Time.zone.now
    previous_year = today.prev_year.year
    initial_date = Time.zone.local(previous_year, initial_date.month, initial_date.day) if initial_date >= today

  	@earning_distribution = EarningDistribution.new(initial_date: initial_date, number_of_months: 12)
  end

  def create
    query = query_params
    @earning_distribution = EarningDistribution.new({
      amount_to_distribute: query['amount_to_distribute'].to_d,
      initial_date: Time.zone.local(query['initial_date(1i)'], query['initial_date(2i)'], 1),
      number_of_months: query['number_of_months'],
      by_shares: (query['by_shares'] == "true")
    })

    respond_to do |format|
      format.html { render :new }
      format.xls { render :new }
      format.json { render json: @earning_distribution.matrix }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:earning_distribution).permit(:amount_to_distribute, :initial_date, :number_of_months, :by_shares, :by_earnings)
    end

    def authorize_for_managing
     authorize EarningDistribution, :manage?
    end

end
