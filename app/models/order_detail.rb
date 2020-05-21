class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  before_save :finalize

  def unit_price
    persisted? ? self[:unit_price] : product.price
  end

  def total_price
    unit_price * quantity
  end

  private

  def product_present
    errors.add(:product, 'is not valid or is not active') if product.nil?
  end

  def order_present
    errors.add(:oder, 'is not a valid order.') if order.nil?
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
