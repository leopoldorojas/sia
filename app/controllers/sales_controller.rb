class SalesController < ApplicationController

  def new
  	@share_operation = ShareOperation.new(operation_date: Time.zone.now, shares_number: 0, cash: 0, dividends: 0, adjustment: 0 )
    @share_value = current_company.share_type.value
  end

  def create
    @share_operation = ShareOperation.new(share_operation_params)
    @share_operation.receipts.build(number: params[:share_operation][:receipt], receipt_date: @share_operation.operation_date)

    respond_to do |format|
      if @share_operation.save
        format.html { redirect_to @share_operation, notice: t('sale.created') }
        format.json { render :show, status: :created, location: @share_operation }
      else
        @share_value = current_company.share_type.value
        format.html { render :new }
        format.json { render json: @share_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_operation_params
      params.require(:share_operation).permit(:operation_date, :share_holder_id, :shares_number, :cash, :dividends, :adjustment)
    end

end
