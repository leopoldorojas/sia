class SalesController < ApplicationController

  def search
    @sales = Sale.all
    @sales = @sales.since(params[:start_date]) if params[:start_date].present?
    @sales = @sales.until(params[:end_date]) if params[:end_date].present?
    @sales = @sales.receipt_like(params[:receipt]) if params[:receipt].present?
    @sales = @sales.share_holder_is(params[:share_holder_id]) if params[:share_holder_id].present?
    respond_to :json
  end

  def index
    @sales = Sale.none
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def new
  	@sale = Sale.new(operation_date: Time.zone.now, shares_required: 0, cash: 0, dividends: 0, adjustment: 0)
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.build_receipt(number: params[:sale][:receipt], receipt_date: @sale.operation_date)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: t('sale.created') }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:operation_date, :share_holder_id, :shares_required, :cash, :dividends, :adjustment, :share_type_id)
    end

end
