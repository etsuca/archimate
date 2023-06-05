class Tag < ApplicationRecord
  has_many :tag_architecture_relationships, dependent: :destroy
  has_many :architecture, through: :tag_architecture_relationships, dependent: :destroy
end
