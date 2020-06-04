class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_order
    @order_detail = @order.order_details.find_by(product_id: order_detail_params[:product_id])
    if @order_detail
      quantity = @order_detail.quantity.to_i + order_detail_params[:quantity].to_i
      @order_detail.update_attributes quantity: quantity
    else
      @order_detail = @order.order_details.new(order_detail_params)
    end
    @order.save
    session[:order_id] = @order.id
    flash[:success] = I18n.t("success.create")
    redirect_to root_path
  end

  def update
    @order = current_order
    @order_details = @order.order_details
    @order_detail = @order_details.find(params[:id]).update_attributes(order_detail_params)
  end

  def destroy
    @order = current_order
    @order_details = @order.order_details
    @order_detail = @order_details.find(params[:id]).destroy
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:product_id, :quantity)
  end

  def current_order
    Order.where(user_id: current_user.id, status: 0).find_or_create_by(status: 0)
  end
end
