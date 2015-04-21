class EarningDistributionsController < ApplicationController
  
  def new
  	@earning_distribution = EarningDistribution.new(amount_to_distribute: 0, initial_month: 1, end_month: 12)
  end

  def create
    @earning_distribution = EarningDistribution.new(query_params)
    @earning_distribution.run

    respond_to do |format|
      format.html { render :new }
      format.json { render json: @earning_distribution }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:earning_distribution).permit(:amount_to_distribute, :initial_month, :end_month)
    end

end
