class SerializableQRCode < JSONAPI::Serializable::Resource
  type 'qr_codes'

  attribute :external_id
  attribute :destination
  attribute :png
  attribute :svg
  attribute :visits_amount
  attribute :created_at
  attribute :updated_at
end
