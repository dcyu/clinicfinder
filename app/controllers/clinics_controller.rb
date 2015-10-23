class ClinicsController < ApplicationController
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]
  before_action :set_countries, only: [:new, :edit]


  def home
  end

  # GET /clinics
  # GET /clinics.json
  def index
    require 'geoip'

    @clinics = Clinic.all
    # user_ip = request.remote_ip
    user_ip = "50.249.25.145"

    @current_location = GeoIP.new('GeoLiteCity.dat').city(user_ip)
    
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show

  end

  # GET /clinics/new
  def new
    @clinic = Clinic.new
  end

  # GET /clinics/1/edit
  def edit
  end

  # POST /clinics
  # POST /clinics.json
  def create
    @clinic = Clinic.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to @clinic, notice: 'Clinic was successfully created.' }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1
  # PATCH/PUT /clinics/1.json
  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to @clinic, notice: 'Clinic was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1
  # DELETE /clinics/1.json
  def destroy
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_url, notice: 'Clinic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_countries
      @countries = [
        [t(:AL, :scope => :countries), "AL"],
        [t(:AD, :scope => :countries), "AD"],
        [t(:AT, :scope => :countries), "AT"],
        [t(:BY, :scope => :countries), "BY"],
        [t(:BE, :scope => :countries), "BE"],
        [t(:BA, :scope => :countries), "BA"],
        [t(:BG, :scope => :countries), "BG"],
        [t(:HR, :scope => :countries), "HR"],
        [t(:CY, :scope => :countries), "CY"],
        [t(:CZ, :scope => :countries), "CZ"],
        [t(:EE, :scope => :countries), "EE"],
        [t(:FO, :scope => :countries), "FO"],
        [t(:FI, :scope => :countries), "FI"],
        [t(:FR, :scope => :countries), "FR"],
        [t(:GR, :scope => :countries), "GR"],
        [t(:HU, :scope => :countries), "HU"],
        [t(:IS, :scope => :countries), "IS"],
        [t(:IE, :scope => :countries), "IE"],
        [t(:IT, :scope => :countries), "IT"],
        [t(:LV, :scope => :countries), "LV"],
        [t(:LI, :scope => :countries), "LI"],
        [t(:LT, :scope => :countries), "LT"],
        [t(:LU, :scope => :countries), "LU"],
        [t(:RS, :scope => :countries), "RS"],
        [t(:MK, :scope => :countries), "MK"],
        [t(:MT, :scope => :countries), "MT"],
        [t(:MD, :scope => :countries), "MD"],
        [t(:ME, :scope => :countries), "ME"],
        [t(:NL, :scope => :countries), "NL"],
        [t(:NO, :scope => :countries), "NO"],
        [t(:PL, :scope => :countries), "PL"],
        [t(:PT, :scope => :countries), "PT"],
        [t(:RO, :scope => :countries), "RO"],
        [t(:RU, :scope => :countries), "RU"],
        [t(:SM, :scope => :countries), "SM"],
        [t(:RS, :scope => :countries), "RS"],
        [t(:SK, :scope => :countries), "SK"],
        [t(:SI, :scope => :countries), "SI"],
        [t(:CH, :scope => :countries), "CH"],
        [t(:GB, :scope => :countries), "GB"],
      ]
    end 

    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:name, :organization, :lat, :lng, :address, :operating_hours, :cost, :scheduling, :eligibility, :country)
    end
end
