class Product < ApplicationRecord
  belongs_to :category, dependent: :destroy

  # Validates
  validates :product_name, presence: true, length: { maximum: Settings.product.product_name.max_length }
  validates :detail, length: {
    minimum: Settings.product.detail.min_length,
    maximum: Settings.product.detail.max_length,
  }

  # Method
  scope :latest, lambda {
                   where('created_at >= created_at or updated_at >= updated_at',
                         created_at: Time.zone.now - 15.days, updated_at: Time.zone.now - 3.days)
                 }
end
