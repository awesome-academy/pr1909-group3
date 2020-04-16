class Promotion < ApplicationRecord
  belongs_to :products, dependent: :destroy

  # Validates
  validates :product_id, presence: true
end
