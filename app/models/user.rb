class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :architecture, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_architecture, through: :likes, source: :architecture

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

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    avatar = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = auth[:info][:name]
      user.name = auth[:info][:name]
      user.avatar = auth[:info][:image]
    end
  end
end