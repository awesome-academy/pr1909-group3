class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_order
    @order_detail = @order.order_details.find_by(product_id: order_detail_params[:product_id])
    if @order_detail
      quantity = @order_detail.quantity.to_i + order_detail_params[:quantity].to_i
      @order_detail.update_attributes quantity: quantity
      flash[:succes] = "So luong do da duoc cap nhat"
    else
      @order_detail = @order.order_details.new(order_detail_params)
    end
    @order.save
    session[:order_id] = @order.id
    flash[:success] = "Do da duoc them vao gio hang"
    redirect_to root_path
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:product_id, :quantity)
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    elsif current_user
      current_user.orders.new status: 0
    end
  end
end
