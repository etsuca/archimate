class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :architecture, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_architecture, through: :likes, source: :architecture
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
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