class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @order_details = OrderDetail.where(order_id: current_user.orders.ids)
  end
end
