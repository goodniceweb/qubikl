class PngQRUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.path_alias}"
  end

  def extension_allowlist
    %w(png)
  end
end
