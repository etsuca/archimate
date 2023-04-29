class Architecture < ApplicationRecord
  mount_uploaders :images, ImagesUploader
  serialize :images, JSON
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :architect, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }

  enum open_range: { unpublish: 0, publish: 1 }

  def self.not_by(user)
    self.where.not(user_id: user.id)
  end
end
