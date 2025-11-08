class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fit: [800, 800]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'sample.jpg'
  end

  def extension_whitelist
    %i[jpg jpeg gif png]
  end

  def fog_authenticated_url_expiration
    3.hours
  end
end
