class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  scope :avg_score, ->(id) { where(product_id: id).average(:score) }
end
