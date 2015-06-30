class EndorsementsController < ApplicationController
  def search
    @endorsements = Endorsement.all
    @endorsements = @endorsements.since(params[:start_date]) if params[:start_date].present?
    @endorsements = @endorsements.until(params[:end_date]) if params[:end_date].present?
    @endorsements = @endorsements.receipt_like(params[:receipt]) if params[:receipt].present?
    @endorsements = @endorsements.share_holder_is(params[:share_holder_id]) if params[:share_holder_id].present?
    @endorsements = @endorsements.source_share_holder_is(params[:source_share_holder_id]) if params[:source_share_holder_id].present?
    respond_to :json
  end

  def index
  end

  def new
  	@endorsement = Endorsement.new(operation_date: Time.zone.now, shares_required: 0)
  end

  def show
    @endorsement = Endorsement.find(params[:id])
  end

  def create
    @endorsement = Endorsement.new(endorsement_params)
    @endorsement.build_receipt(number: params[:endorsement][:receipt], receipt_date: @endorsement.operation_date) if params[:endorsement][:receipt].present?

    respond_to do |format|
      if @endorsement.save
        format.html { redirect_to @endorsement, notice: t('endorsement.created') }
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
      params.require(:endorsement).permit(:operation_date, :share_holder_id, :source_share_holder_id, :shares_required, :share_type_id)
    end
end
