class OrdersController < ApplicationController
  def new
    @order = current_user.orders.new(name: current_user.name,
                                     phone: current_user.phone, address: current_user.address)
  end

  def create
    @order = Order.where(user_id: current_user.id, status: 0).update(order_params)
    @a = Order.find_by(user_id: current_user.id, status: 0).get_subtotal
    @order = Order.where(user_id: current_user.id, status: 0).update(status: 1, subtotal: @a)
    @order_details = OrderDetail.find_by(order_id: current_user.orders.ids).destroy
    flash[:success] = I18n.t("payment.success")
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :phone, :address, :name)
  end
end
