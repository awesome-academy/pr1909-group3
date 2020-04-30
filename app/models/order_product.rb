class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :product_name, :detail, :price, to: :product

  after_create :decrement_product_quantity!

  def decrement_product_quantity!
    product.decrement!(:quantity, quantity)
  end

  def get_total_price
    price * quantity
  end
end
