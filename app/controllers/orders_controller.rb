class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.latest
  end

  def new
    @order = current_user.orders.build(reciever_name: current_user.product_name,
                                       phone: current_user.phone, address: current_user.address)
  end

  def create
    @order = current_user.orders.build(order_params)
    products_cart = load_cookie_cart
    build_placements(products_cart)
    set_total

    if @order.save
      clear_cart
      flash[:success] = "Cam on"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit :total_price, :phone, :address, :reciever_name
  end

  def build_placements(products_cart)
    products_cart.each do |k, v|
      @order.order_products.build(product_id: k, quantity: v)
    end
  end

  def set_total
    @order.total_price = 0
    @order.order_products.each do |placement|
      @order.total_price += placement.product.price * placement.quantity
    end
  end
end
