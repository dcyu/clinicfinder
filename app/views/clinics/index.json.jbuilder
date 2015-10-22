json.array!(@clinics) do |clinic|
  json.extract! clinic, :id, :name, :organization_id, :lat, :lng, :address, :operating_hours, :cost, :scheduling, :eligibility, :country
  json.url clinic_url(clinic, format: :json)
end
