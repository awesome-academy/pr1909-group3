module OrdersHelper
  def get_price_order order
    total = 0
    order.order_products.each do |placement|
      total += placement.quantity * placement.product.price
    end
    total
  end
end
