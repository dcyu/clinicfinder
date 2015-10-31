json.array!(@capabilities) do |capability|
  json.extract! capability, :id, :topic_id, :clinic_id
  json.url capability_url(capability, format: :json)
end
