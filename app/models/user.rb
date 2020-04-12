class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # enum
  enum permission: { admin: 1, staff: 2, customer: 3 }
  # Validates
  validates :email, presence: true
  validates :permission, presence: true
end
