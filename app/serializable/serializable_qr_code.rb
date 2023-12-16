class SerializableQRCode < JSONAPI::Serializable::Resource
  type 'qr_codes'

  attribute :path_alias
  attribute :destination
  attribute :domain
  attribute :png
  attribute :png_url do |obj|
    opts = Rails.application.default_url_options
    "http://#{opts[:host]}:#{opts[:port]}#{obj.instance_variable_get("@object").png.url}"
  end
  attribute :svg
  attribute :visits_amount
  attribute :created_at
  attribute :updated_at
end
