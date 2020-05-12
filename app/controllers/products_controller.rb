class ProductsController < ApplicationController
  before_action :get_product, only: [:show]

  def index
    @q = Product.ransack params[:q]
    @products = @q.result(distinct: true).page(params[:page])
    @order_detail = current_order.order_details.new
  end

  def show
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :detail, :price, :quantity, :slug, :category_id)
  end
end
