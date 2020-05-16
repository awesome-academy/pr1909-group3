class OrdersController < ApplicationController
  def new
    @order = current_user.orders.build(reciever_name: current_user.name,
                                       phone: current_user.phone, address: current_user.address)
  end

  def create
    @order = Order.where(user_id: current_user.id, status: 0).update(order_params)
    byebug
    @order_details = OrderDetail.find_by(order_id: current_user.orders.ids)
    get_subtotal
    if @order.save
      OrderDetail.find_by(order_id: current_user.orders.ids).destroy
      flash[:success] = I18n.t("payment.success")
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :phone, :address, :reciever_name, :status)
  end

  def get_subtotal
    @order.subtotal = order_details.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end
end
