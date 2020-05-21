class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :orders
  has_many :reviews, dependent: :destroy
  # enum
  enum permission: { admin: 1, staff: 2, customer: 3 }
  # Validates
  validates :email, presence: true, length: { maximum: Settings.user.email.max_length }
  validates :name, presence: true, length: { maximum: Settings.user.name.max_length }
  validates :permission, presence: true

  # OmniAuth
  def self.from_omniauth(auth)
    result = User.where(email: auth.info.email).first
    if result
      return result
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.uid = auth.uid
        user.provider = auth.provider

        #  If you are using confirmable and the provider(s) you use validate emails
        # user.skip_confirmation!
      end
    end
  end
end
