class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]
  
  validates :name, presence: true, length: { maximum: 255 }, on: :create
  validate :password_complexity
  def password_complexity
    return if password.blank? || password =~ /(?=.*?[0-9])/
    errors.add :password, "は数字と英字を混ぜたものを入力してください"
  end
  has_many :architecture, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_architecture, through: :likes, source: :architecture

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        name:     auth[:info][:name],
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end
    user.skip_confirmation!
    user
  end

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

    private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end