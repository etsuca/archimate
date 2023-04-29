class User < ApplicationRecord
  has_many :architecture, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_architecture, through: :likes, source: :architecture
  
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end

  def like(architecture)
    like_architecture << architecture
  end

  def unlike(architecture)
    like_architecture.delete(architecture)
  end

  def like?(architecture)
    like_architecture.include?(architecture)
  end
end