class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :contacts

  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  VALID_PHONE_REGEX = /\A[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$\z/
  validates :phone, presence: true,
            format: {with: VALID_PHONE_REGEX}, allow_nil: true
  validates :address, presence: true,
            length: {maximum: Settings.user.address.max_length}, allow_nil: true
  validates :password, presence: true,
            length: {minimum: Settings.user.password.min_length}, allow_nil: true

end
