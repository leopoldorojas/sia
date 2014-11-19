class ShareOperationsController < ApplicationController
  before_action :set_share_operation, only: [:show, :edit, :update, :destroy]

  # GET /share_operations
  # GET /share_operations.json
  def index
    @share_operations = ShareOperation.all
  end

  # GET /share_operations/1
  # GET /share_operations/1.json
  def show
  end

  # GET /share_operations/new
  def new
    @share_operation = ShareOperation.new
  end

  # GET /share_operations/1/edit
  def edit
  end

  # POST /share_operations
  # POST /share_operations.json
  def create
    @share_operation = ShareOperation.new(share_operation_params)

    respond_to do |format|
      if @share_operation.save
        format.html { redirect_to @share_operation, notice: 'Share operation was successfully created.' }
        format.json { render :show, status: :created, location: @share_operation }
      else
        format.html { render :new }
        format.json { render json: @share_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /share_operations/1
  # PATCH/PUT /share_operations/1.json
  def update
    respond_to do |format|
      if @share_operation.update(share_operation_params)
        format.html { redirect_to @share_operation, notice: 'Share operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @share_operation }
      else
        format.html { render :edit }
        format.json { render json: @share_operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /share_operations/1
  # DELETE /share_operations/1.json
  def destroy
    @share_operation.destroy
    respond_to do |format|
      format.html { redirect_to share_operations_url, notice: 'Share operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_operation
      @share_operation = ShareOperation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_operation_params
      params.require(:share_operation).permit(:operation_date, :share_holder_id, :shares_required, :cash, :dividends, :adjustment)
    end
end
