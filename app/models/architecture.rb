class Architecture < ApplicationRecord
  has_many_attached :images
  has_many :tag_architecture_relationships, dependent: :destroy
  has_many :tags, through: :tag_architecture_relationships, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :architect, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
  validates :images, attached_file_presence: true
  validates :images, attached_file_number: { maximum: 10 }
  validates :images, attached_file_size: { maximum: 5.megabytes }
  validates :images, attached_file_type: { pattern: /^image\// }

  enum open_range: { unpublish: 0, publish: 1 }
  enum experience: { possible: 0, impossible: 1 }

  def self.ransackable_attributes(auth_object = nil)
    ["architect", "created_at", "description", "id", "images", "location", "name", "open_range", "updated_at", "user_id"]
  end

  def self.not_by(user)
    self.where.not(user_id: user.id)
  end

  def by?(user)
    self.user_id == user.id
  end

  def self.ransackable_associations(auth_object = nil)
    ["tag_architecture_relationships", "tags", "user"]
  end
end
