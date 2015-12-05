class ClinicsController < ApplicationController
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]
  before_action :set_countries_and_time
  before_action :set_location
  before_filter :authenticate_admin!, only: [:edit, :update, :destroy]

  def csv
  end

  def home
  end

  def about
  end

  def select_topic
    @topics = Topic.all
  end

  # GET /clinics
  # GET /clinics.json
  def index
    @unverified_clinics = Clinic.where(verified: nil) + Clinic.where(verified: false)

    if params[:topic].present?
      @clinics = Topic.find_by(name: params[:topic]).available_clinics.select{|clinic| clinic.verified}
    else
      @clinics = Clinic.where(verified: true)
    end

    @clinics_sorted_by_distance = []

    if @lat_lng
      location = Geocoder.search(@lat_lng).first

      @clinics.each do |clinic|
        @clinics_sorted_by_distance << [clinic, Geocoder::Calculations.distance_between([@lat_lng.first, @lat_lng.last], [clinic.lat, clinic.lng], :units => :km).round(1)]
      end
      if location && location.city
        @current_location = [location.city, location.country]
      end
    else
      user_ip = request.remote_ip

      location = GeoIP.new('GeoLiteCity.dat').city(user_ip)

      if location
        @clinics.each do |clinic|
          @clinics_sorted_by_distance << [clinic, Geocoder::Calculations.distance_between([location.latitude, location.longitude], [clinic.lat, clinic.lng], :units => :km).round(2)]
        end
        @current_location = [location.city_name, location.country_name]
      else
        @clinics.each do |clinic|
          @clinics_sorted_by_distance << [clinic, 0]
        end
      end
    end

    @clinics_sorted_by_distance.sort_by!{|clinic| clinic.last}

    respond_to do |format|
      format.html

      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"ClinicFinder Clinics\".csv"
        headers['Content-Type'] ||= 'text/csv'

        render layout: false
      end

    end
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show
    @shifts = @clinic.shifts.select{|s| s.open}
    @capabilities = @clinic.capabilities.select{|c| c.available}
  end

  # GET /clinics/new
  def new
    @clinic = Clinic.new

    @shifts = [
      @clinic.shifts.build(day: "mon"),
      @clinic.shifts.build(day: "tue"),
      @clinic.shifts.build(day: "wed"),
      @clinic.shifts.build(day: "thu"),
      @clinic.shifts.build(day: "fri"),
      @clinic.shifts.build(day: "sat"),
      @clinic.shifts.build(day: "sun")
    ]

    @capabilities = []

    Topic.all.each do |topic|
      @capabilities << @clinic.capabilities.build(topic_id: topic.id)
    end
  end

  # GET /clinics/1/edit
  def edit
    @shifts = @clinic.shifts.sort
    @capabilities = @clinic.capabilities

    Topic.all.each do |topic|
      unless @clinic.topics.include?(topic)
        @capabilities << @clinic.capabilities.build(topic_id: topic.id)
      end
    end

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
    def set_location
      if cookies[:lat_lng]
        @lat_lng = cookies[:lat_lng].split("|")
      end
    end

    def set_countries_and_time

      @times = ["0:00", "0:30", "1:00", "1:30", "2:00", "2:30", "3:00", "3:30", "4:00", "4:30", "5:00", "5:30", "6:00", "6:30", "7:00", "7:30", "8:00", "8:30", "9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30", "24:00"]

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
        [t(:DK, :scope => :countries), "DK"],
        [t(:EE, :scope => :countries), "EE"],
        [t(:FO, :scope => :countries), "FO"],
        [t(:FI, :scope => :countries), "FI"],
        [t(:FR, :scope => :countries), "FR"],
        [t(:GE, :scope => :countries), "GE"],
        [t(:DE, :scope => :countries), "DE"],
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
        [t(:RS, :scope => :countries), "RS"],
        [t(:SM, :scope => :countries), "SM"],
        [t(:RS, :scope => :countries), "RS"],
        [t(:SK, :scope => :countries), "SK"],
        [t(:SI, :scope => :countries), "SI"],
        [t(:ES, :scope => :countries), "ES"],
        [t(:SE, :scope => :countries), "SE"],
        [t(:CH, :scope => :countries), "CH"],
        [t(:TR, :scope => :countries), "TR"],
        [t(:UA, :scope => :countries), "UA"],
        [t(:GB, :scope => :countries), "GB"],
        [t(:VA, :scope => :countries), "VA"],
      ]
    end 

    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:name, :organization, :lat, :lng, :address, :operating_hours, :phone, :cost, :scheduling, :eligibility, :country, :contact_name, :contact_email, :contact_phone, :additional_info, :verified, shifts_attributes: [:id, :day, :opening_time, :closing_time, :clinic_id, :open, :opening_time2, :closing_time2], capabilities_attributes: [:id, :clinic_id, :topic_id, :available])
    end
end
