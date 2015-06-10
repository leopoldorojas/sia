class EndorsementsController < ApplicationController
  def search
  end

  def index
  end

  def new
  	@endorsement = Endorsement.new(operation_date: Time.zone.now, shares_required: 0, cash: 0, dividends: 0, adjustment: 0)
  end

  def create
    @endorsement = Endorsement.new(share_operation_params)
    @endorsement.build_receipt(number: params[:share_operation][:receipt], receipt_date: @endorsement.operation_date)

    respond_to do |format|
      if @endorsement.save
        format.html { redirect_to @endorsement, notice: t('sale.created') }
        format.json { render :show, status: :created, location: @endorsement }
      else
        format.html { render :new }
        format.json { render json: @endorsement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def endorsement_params
      params.require(:endorsement).permit(:operation_date, :share_holder_id, :shares_required, :cash, :dividends, :adjustment, :share_type_id)
    end
end
