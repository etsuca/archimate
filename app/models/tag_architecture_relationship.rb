class TagArchitectureRelationship < ApplicationRecord
  belongs_to :architecture
  belongs_to :tag

  validates :tag_id, uniqueness: { scope: :architecture_id }
end
