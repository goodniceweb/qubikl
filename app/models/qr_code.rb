class QRCode < ApplicationRecord
  attribute :scans, :integer, default: 0

  mount_uploader :svg, SvgQRUploader
  mount_uploader :png, PngQRUploader

  validates :data, presence: true

  before_save :ensure_external_id
  after_create :ensure_svg
  after_create :ensure_png

  private

  def ensure_external_id
    return if external_id.present?

    potential_external_id = SecureRandom.hex(5)
    potential_external_id = SecureRandom.hex(5) while self.class.exists?(external_id: potential_external_id)

    self.external_id = potential_external_id
  end

  def store_file(type, content)
    tempfile = Tempfile.new(["qr_code-#{external_id}", ".#{type}"])
    tempfile.binmode
    tempfile.write(content.public_send(:"as_#{type}"))
    tempfile.close

    File.open(tempfile.path) do |file|
      public_send(:"#{type}=", file)
      save!
    end

    File.delete(tempfile.path)
  end

  def ensure_svg
    return if svg.present?

    store_file(:svg, generete_qr_code)
  end

  def ensure_png
    return if png.present?

    store_file(:png, generete_qr_code)
  end

  def generete_qr_code
    RQRCode::QRCode.new(build_link)
  end

  def build_link
    relative_path = Rails.application.routes.url_helpers.qr_code_link_path(external_id)
    "#{domain}#{relative_path}"
  end
end
