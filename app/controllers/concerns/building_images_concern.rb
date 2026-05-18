module BuildingImagesConcern
  extend ActiveSupport::Concern

  MAX_IMAGE_WIDTH = 1920
  MAX_IMAGE_HEIGHT = 1920
  CONVERTIBLE_IMAGE_CONTENT_TYPES = %w[image/jpeg image/png image/heic image/heif].freeze
  HEIC_IMAGE_CONTENT_TYPES = %w[image/heic image/heif].freeze
  private_constant :MAX_IMAGE_WIDTH, :MAX_IMAGE_HEIGHT, :CONVERTIBLE_IMAGE_CONTENT_TYPES, :HEIC_IMAGE_CONTENT_TYPES

  def resize_and_convert(images)
    images.each do |image|
      if image.content_type.start_with?(*CONVERTIBLE_IMAGE_CONTENT_TYPES)
        begin
          resize_image(image)
          convert_to_jpg(image) if heic_or_heif?(image)
        rescue MiniMagick::Error, ImageProcessing::Error => e
          Rails.logger.error("Image processing failed: #{e.message}")
          @building.errors.add(:images, t('errors.messages.invalid_file_type'))
        end
      else
        @building.errors.add(:images, t('errors.messages.invalid_file_type'))
      end
    end
  end

  private

  def resize_image(image)
    image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).resize_to_fit(MAX_IMAGE_WIDTH, MAX_IMAGE_HEIGHT).call
  end

  def convert_to_jpg(image)
    image.tempfile = ImageProcessing::MiniMagick.source(image.tempfile).convert('jpg').call
  end

  def heic_or_heif?(image)
    image.content_type.start_with?(*HEIC_IMAGE_CONTENT_TYPES)
  end
end
