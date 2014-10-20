class ShareTypesController < ApplicationController
  before_action :set_share_type, only: [:show, :edit, :update, :destroy]

  # GET /share_types
  # GET /share_types.json
  def index
    @share_types = ShareType.all
    @reference = "ShareType"
  end

  # GET /share_types/1
  # GET /share_types/1.json
  def show
  end

  # GET /share_types/new
  def new
    @share_type = ShareType.new
  end

  # GET /share_types/1/edit
  def edit
  end

  # POST /share_types
  # POST /share_types.json
  def create
    @share_type = ShareType.new(share_type_params)

    respond_to do |format|
      if @share_type.save
        format.html { redirect_to @share_type, notice: 'Share type was successfully created.' }
        format.json { render :show, status: :created, location: @share_type }
      else
        format.html { render :new }
        format.json { render json: @share_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /share_types/1
  # PATCH/PUT /share_types/1.json
  def update
    respond_to do |format|
      if @share_type.update(share_type_params)
        format.html { redirect_to @share_type, notice: 'Share type was successfully updated.' }
        format.json { render :show, status: :ok, location: @share_type }
      else
        format.html { render :edit }
        format.json { render json: @share_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /share_types/1
  # DELETE /share_types/1.json
  def destroy
    @share_type.destroy
    respond_to do |format|
      format.html { redirect_to share_types_url, notice: 'Share type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_share_type
      @share_type = ShareType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def share_type_params
      params.require(:share_type).permit(:name, :value)
    end
end
