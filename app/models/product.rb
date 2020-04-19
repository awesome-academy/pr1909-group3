class Product < ApplicationRecord
  belongs_to :category, dependent: :destroy

  # Validates
  validates :product_name, presence: true, length: { maximum: 35 }
  validates :detail, length: { minimum: 14, maximum: 300 }

  # Method
  scope :latest, lambda { where('created_at >= ? or updated_at >= ?', Time.now - 15.days, Time.now - 3.days) }
end
