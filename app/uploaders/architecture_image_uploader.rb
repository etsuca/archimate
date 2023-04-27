class ArchitectureImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'architecture_placeholder.png'
  end

  def extension_whitelist
    %i[jpg jpeg gif png]
  end

end
