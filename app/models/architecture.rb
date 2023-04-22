class Architecture < ApplicationRecord
  belongs_to :user
  belongs_to :open_range

  validates :name, presence: true, length: { maximum: 255 }
  validates :location, presence: true, length: { maximum: 255 }
end
