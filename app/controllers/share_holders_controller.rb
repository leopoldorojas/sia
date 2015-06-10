class ShareHoldersController < ApplicationController
  before_action :set_share_holder, only: [:show, :edit, :update, :destroy]

  def search
    @share_holders = ShareHolder.all
    @share_holders = @share_holders.where("upper(name) LIKE upper(?)", "%#{params[:name]}%" ) if params[:name].present?
    @share_holders = @share_holders.location_in(params[:location_id]) if params[:location_id].present?
    respond_to :json
  end

  # GET /share_holders
  # GET /share_holders.json
  def index
    @share_holders = ShareHolder.all
  end

  # GET /share_holders/1
  # GET /share_holders/1.json
  def show
    @sales = Sale.share_holder_is @share_holder
  end

  # GET /share_holders/new
  def new
    @share_holder = ShareHolder.new
    authorize @share_holder
  end

  # GET /share_holders/1/edit
  def edit
    authorize @share_holder
    @readonly = policy(@share_holder).block_allowed_fields?
  end

  # POST /share_holders
  # POST /share_holders.json
  def create
    @share_holder = ShareHolder.new(share_holder_params)
    authorize @share_holder

    respond_to do |format|
      if @share_holder.save
        format.html { redirect_to @share_holder, notice: t('share_holder.created') }
        format.json { render :show, status: :created, location: @share_holder }
      else
        format.html { render :new }
        format.json { render json: @share_holder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /share_holders/1
  # PATCH/PUT /share_holders/1.json
  def update
    respond_to do |format|
      if @share_holder.update(share_holder_params)
        format.html { redirect_to @share_holder, notice: t('share_holder.updated') }
        format.json { render :show, status: :ok, location: @share_holder }
      else
        format.html { render :edit }
        format.json { render json: @share_holder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /share_holders/1
  # DELETE /share_holders/1.json
  def destroy
    @share_holder.destroy
    respond_to do |format|
      format.html { redirect_to share_holders_url, notice: t('share_holder.destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_holder
      @share_holder = ShareHolder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_holder_params
      params.require(:share_holder).permit(:name, :identifier, :contact, :phone, :email, :location_id, :equity, :earnings, :stock_prepaid)
    end
end
