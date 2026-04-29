class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :name, presence: true, length: { maximum: 255 }, on: :create
  has_many :buildings, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_buildings, through: :likes, source: :building

  def self.find_for_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    user ||= User.create(
      name: 'ゲストユーザー',
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      avatar: auth.info.image
    )

    user
  end

  def own?(object)
    id == object.user_id
  end

  def like(building)
    liked_buildings << building
  end

  def unlike(building)
    liked_buildings.delete(building)
  end

  def like?(building)
    liked_buildings.include?(building)
  end

  def update_without_password(params, *)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *)
    clean_up_passwords
    result
  end
end
