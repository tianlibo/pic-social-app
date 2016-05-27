class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :qiniu
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  VERSION_SIZES = {
    thumb: 240
  }

  # fill, fit, limit的区别：
  # fill是刚好填满正方形
  # fit是刚好不超出正方形
  # limit和fit一样，当时在图形比size小时，不会放大。
  VERSION_SIZES.each do |version_name, size|
    version version_name do
      process resize_to_fit: [size, size]
    end
  end
end