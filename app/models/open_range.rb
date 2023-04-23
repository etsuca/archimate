class OpenRange < ApplicationRecord
  has_many :architecture, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
end
