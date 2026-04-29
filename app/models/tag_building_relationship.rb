class TagBuildingRelationship < ApplicationRecord
  belongs_to :building
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :building_id }
end
