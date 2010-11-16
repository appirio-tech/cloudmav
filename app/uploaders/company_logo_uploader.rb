# encoding: utf-8

class CompanyLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :s3

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  process :resize_to_fit => [160, 160]
  process :convert => "jpg"

  version :medium do
    process :resize_to_fit => [72, 72]
  end

  version :thumb do
    process :resize_to_fit => [48, 48]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
