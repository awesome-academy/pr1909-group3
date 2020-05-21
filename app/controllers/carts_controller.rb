class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @count = Order.where(user_id: current_user.id, status: 0).count
    if @count > 1
      @order_details = OrderDetail.where(order_id: current_user.orders.ids)
    else
      redirect_to root_path
      flash[:danger] = I18n.t "layout.cart.noti"
    end
  end
end
