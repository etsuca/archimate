class Tag < ApplicationRecord
  has_many :tag_building_relationships, dependent: :destroy
  has_many :buildings, through: :tag_building_relationships, dependent: :destroy
end
