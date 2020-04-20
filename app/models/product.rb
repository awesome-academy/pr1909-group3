class Product < ApplicationRecord
  belongs_to :category, dependent: :destroy

  # Validates
  validates :product_name, presence: true, length: { maximum: 35 }
  validates :detail, length: { minimum: 14, maximum: 300 }

  # Method
  scope :latest, -> {
                   where('created_at >= created_at or updated_at >= updated_at',
                         created_at: Time.zone.now - 15.days, updated_at: Time.zone.now - 3.days)
                 }
end
