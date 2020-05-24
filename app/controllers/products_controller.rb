class ProductsController < ApplicationController
  before_action :get_product, only: [:show]
  before_action :load_review, only: [:show]
  def index
    @q = Product.ransack params[:q]
    @products = @q.result(distinct: true).page(params[:page])
  end

  def show
  end

  private

  def get_product
    @product = Product.find(params[:id])
  end

  def load_review
    @reviews = @product.reviews
    @review ||= Review.new(score: Settings.products.max_stars)
  end

  def product_params
    params.require(:product).permit(:product_name, :detail, :price, :quantity, :slug, :category_id)
  end
end
