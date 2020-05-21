class Category < ApplicationRecord
  has_many :products

  # Validates
  validates :category_name, presence: true,
                            length: { maximum: Settings.category.category_name.max_length }, uniqueness: true
  belongs_to :parent, class_name: Category.name, optional: true,
                      foreign_key: :parent_code, primary_key: :code
  scope :roots, -> { where(parent_code: "0") }
end
