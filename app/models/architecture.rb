class Architecture < ApplicationRecord
  belongs_to :user
  belongs_to :open_range

  validates :name, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :architect, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 65_535 }
end
