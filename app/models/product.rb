class Product < ApplicationRecord
  belongs_to :category, dependent: :destroy

  # Validates
  validates :product_name, presence: true, length: { maximum: 35 }
  validates :detail, length: { minimum: 14, maximum: 300 }

  # Method
  def self.lates
    where(
      'created_at >= :fifteen_days_ago or updated_at >= :three_days_ago',
      :fifteen_days_ago => Time.now - 15.days,
      :three_days_ago => Time.now - 3.days
    )
  end
end
