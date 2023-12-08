class QRCode < ApplicationRecord
  mount_uploader :svg, SvgQRUploader
  mount_uploader :png, PngQRUploader

  validates :destination, :path_alias, presence: true
  validates :path_alias, uniqueness: true

  before_validation :ensure_path_alias
  before_create :ensure_correct_destination
  after_create :ensure_svg
  after_create :ensure_png

  private

  def ensure_path_alias
    return if path_alias.present?

    potential_path_alias = SecureRandom.hex(5)
    potential_path_alias = SecureRandom.hex(5) while self.class.exists?(path_alias: potential_path_alias)

    self.path_alias = potential_path_alias
  end

  def ensure_correct_destination
    return if destination.start_with?("http", "//")

    self.destination = "//#{destination}"
  end

  def ensure_svg
    return if svg.present?

    store_file(:svg, generete_qr_code)
  end

  def ensure_png
    return if png.present?

    store_file(:png, generete_qr_code)
  end

  def store_file(type, content)
    tempfile = Tempfile.new(["qr_code-#{path_alias}", ".#{type}"])
    tempfile.binmode
    tempfile.write(content.public_send(:"as_#{type}"))
    tempfile.close

    File.open(tempfile.path) do |file|
      public_send(:"#{type}=", file)
      save!
    end

    File.delete(tempfile.path)
  end

  def generete_qr_code
    RQRCode::QRCode.new(build_link)
  end

  def build_link
    relative_path = Rails.application.routes.url_helpers.qr_code_link_path(path_alias)
    "#{domain}#{relative_path}"
  end
end
