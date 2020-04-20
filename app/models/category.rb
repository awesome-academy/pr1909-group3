class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  # Validates
  validates :category_name, presence: true,
                            length: { maximum: Settings.category.category_name.max_length }, uniqueness: true
end
