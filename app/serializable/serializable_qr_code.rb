class SerializableQRCode < JSONAPI::Serializable::Resource
  type 'qr_codes'

  attribute :external_id
  attribute :data
  attribute :png
  attribute :svg
  attribute :scans
  attribute :created_at
  attribute :updated_at
end
