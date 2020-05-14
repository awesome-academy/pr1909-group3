class Promotion < ApplicationRecord
  belongs_to :product, dependent: :destroy

  # Validates
  validates :product_id, presence: true
end
