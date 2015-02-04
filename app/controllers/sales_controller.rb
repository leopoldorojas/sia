class SalesController < ApplicationController

  def search
    @share_operations = params[:start_date] ? ShareOperation.where("operation_date >= ? AND operation_date <= ? AND share_holder_id = ?", params[:start_date], params[:end_date], params[:share_holder_id]) : ShareOperation.none
    respond_to :json
  end

  def index
    @share_operations = ShareOperation.none
  end

  def new
  	@share_operation = ShareOperation.new(operation_date: Time.zone.now, shares_required: 0, cash: 0, dividends: 0, adjustment: 0)
  end

  def create
    @share_operation = ShareOperation.new(share_operation_params)
    @share_operation.build_receipt(number: params[:share_operation][:receipt], receipt_date: @share_operation.operation_date)

    respond_to do |format|
      if @share_operation.save
        format.html { redirect_to @share_operation, notice: t('sale.created') }
        format.json { render :show, status: :created, location: @share_operation }
      else
        format.html { render :new }
        format.json { render json: @share_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_operation_params
      params.require(:share_operation).permit(:operation_date, :share_holder_id, :shares_required, :cash, :dividends, :adjustment, :share_type_id)
    end

end
