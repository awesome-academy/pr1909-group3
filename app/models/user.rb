class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Validates
  validates :email, presence: true
  validates :permission, presence: true, inclusion: { in: %w(0 1) }
end
