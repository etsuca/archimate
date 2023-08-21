class Architecture < ApplicationRecord
  has_many_attached :images
  has_many :tag_architecture_relationships, dependent: :destroy
  has_many :tags, through: :tag_architecture_relationships, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, format: { without: /[!@#\$%\^&\*\\?{}:"<>|¥;']/, message: 'に使用できない文字が含まれています' }
  validates :location, presence: true, length: { maximum: 255 }
  validates :architect, length: { maximum: 255 }
  validates :architect, format: { without: /[!@#\$%\^&\*\\?{}:"<>|¥;']/, message: 'に使用できない文字が含まれています' }
  validates :description, length: { maximum: 65_535 }
  validates :images, attached_file_presence: true
  validates :images, attached_file_number: { maximum: 10 }
  validates :images, attached_file_size: { maximum: 10.megabytes }
  validates :images, attached_file_type: { pattern: %r{^image/(jpeg|png|tiff|heic|heif)$} }

  enum open_range: { unpublish: 0, publish: 1 }
  enum experience: { possible: 0, impossible: 1 }

  def self.ransackable_attributes(_auth_object = nil)
    ['architect', 'created_at', 'description', 'id', 'images', 'location', 'name', 'open_range', 'updated_at', 'user_id']
  end

  def self.not_by(user)
    where.not(user_id: user.id)
  end

  def by?(user)
    user_id == user.id
  end

  def self.ransackable_associations(_auth_object = nil)
    ['tag_architecture_relationships', 'tags', 'user']
  end
end
