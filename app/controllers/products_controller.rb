class ProductsController < ApplicationController
  before_action :get_product, only: [:index, :show]

  def index
    @product = Product.all.latest
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
