class PagesController < ApplicationController
  def index
    @product = Product.all.latest
  end
end
