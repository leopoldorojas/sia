class SalesController < ApplicationController

  def new
  	@share_operation = ShareOperation.new(operation_date: Time.zone.now)
  end

  def create
    @share_operation = ShareOperation.new(share_operation_params)

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
      params.require(:share_issue).permit(:operation_date, :share_holder_id, :shares_number, :cash, :dividends, :adjustment)
    end

end
