class PagesController < ApplicationController
  def index
    @product = Product.all
  end
end
