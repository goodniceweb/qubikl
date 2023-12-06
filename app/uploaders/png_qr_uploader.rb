class PngQRUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.external_id}"
  end

  def extension_allowlist
    %w(png)
  end
end
