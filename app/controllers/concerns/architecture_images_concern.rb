module ArchitectureImagesConcern
  extend ActiveSupport::Concern

  def resize_and_convert(images)
    images.each do |image|
      if image.content_type.start_with?('image/jpeg', 'image/png', 'image/heic', 'image/heif')
        resize_image(image)
        convert_to_jpg(image) if heic_or_heif?(image)
      else
        @architecture.errors.add(:images, t('errors.messages.invalid_file_type'))
      end
    end
  end

  private

  def resize_image(image)
    image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).resize_to_fit(1920, 1920).call
  end

  def convert_to_jpg(image)
    image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).convert('jpg').call
  end

  def heic_or_heif?(image)
    image.content_type.start_with?('image/heic', 'image/heif')
  end
end
