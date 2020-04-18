class PagesController < ApplicationController
  def index
  end

  def home
    @product = Product.all
  end
end
