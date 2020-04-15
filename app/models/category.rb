class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  # Validates
  validates :category_name, presence: true, length: { maximum: 16 }
end
