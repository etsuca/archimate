class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :name, presence: true, length: { maximum: 255 }, on: :create
  has_many :architecture, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_architecture, through: :likes, source: :architecture

  def self.find_for_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    user ||= User.create(
      name: auth.info.name,
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

  def like(architecture)
    like_architecture << architecture
  end

  def unlike(architecture)
    like_architecture.delete(architecture)
  end

  def like?(architecture)
    like_architecture.include?(architecture)
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

  private

  def password_complexity
    return if password.blank? || password =~ /(?=.*?[a-z])(?=.*?[0-9])/

    errors.add :password, 'は数字と英字を混ぜたものを入力してください'
  end

  private_class_method def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
