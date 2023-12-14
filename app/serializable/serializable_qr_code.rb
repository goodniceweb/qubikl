class SerializableQRCode < JSONAPI::Serializable::Resource
  type 'qr_codes'

  attribute :path_alias
  attribute :destination
  attribute :png
  attribute :svg
  attribute :visits_amount
  attribute :created_at
  attribute :updated_at
end
