# frozen_string_literal: true

# User model
class User < ApplicationRecord
  enum permission: { admin: 1, staff: 2, customer: 3 }
  validates :name, presence: true,
                   length: { maximum: Settings.user.name.max_length }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: Settings.user.email.max_length },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  VALID_PHONE_REGEX = /\A[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$\z/.freeze
  validates :phone, presence: true, format: { with: VALID_PHONE_REGEX }
  validates :address,
            length: { maximum: Settings.user.address.max_length }
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: Settings.user.password.min_length }, allow_nil: true
end
