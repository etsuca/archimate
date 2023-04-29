class Like < ApplicationRecord
  belongs_to :user
  belongs_to :architecture

  validates :user_id, uniqueness: { scope: :architecture_id }
end
