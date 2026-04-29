class Like < ApplicationRecord
  belongs_to :user
  belongs_to :building

  validates :user_id, uniqueness: { scope: :building_id }
end
