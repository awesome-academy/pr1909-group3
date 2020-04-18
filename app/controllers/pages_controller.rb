class PagesController < ApplicationController
  def index
    @product = Product.paginate(page: params[:page])
  end

  def home
    @product = Product.all
  end

  private

  def home_params
    params.require(:product).permit(:product_name, :detail, :price, :quantity, :slug, :category_id)
  end
end
