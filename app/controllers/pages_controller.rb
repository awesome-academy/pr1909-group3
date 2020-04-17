class PagesController < ApplicationController
  def home
    @product = Product.all
  end

  def index
  end
end
