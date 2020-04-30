class CartsController < ApplicationController
  before_action :authenticate_user!

  def shopping
    add_product params[:carts][:product_id], params[:carts][:quantity].to_i
    respond_to do |format|
      format.html { redirect_to carts_path }
      format.js
    end
  end

  def show
    orders = load_cookie_cart
    load_products(orders)
  end

  def update
    update_cart params[:product_id], params[:quantity].to_i
    redirect_to carts_path
  end

  def destroy
    remove_product params[:product_id]
    redirect_to carts_path
  end

  private

  def load_products(orders)
    @products = Product.find_ids(orders.keys)
    @products.each do |p|
      p.amount_added = orders[p.id.to_s]
    end
  end
end
