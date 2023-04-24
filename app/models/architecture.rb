class Architecture < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :architect, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
end
