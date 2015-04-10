class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  before_action :authorize_for_managing, except: [:index, :show]

  # GET /locations
  # GET /locations.json
  def index
    @locations = type_class.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = type_class.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: t("#{type.underscore}.created") }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: t("#{type.underscore}.updated") }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to self.send("#{type.tableize}_url".to_sym), notice: t("#{type.underscore}.destroyed") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = type_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(type.underscore.to_sym).permit(:code, :name, :type, :parent_id)
    end

    def set_type 
      @type = type 
    end

    def type
      Location.types.include?(params[:type]) ? params[:type] : "Location"
    end

    def type_class 
      type.constantize 
    end

    def authorize_for_managing
      authorize Location, :manage?
    end
end