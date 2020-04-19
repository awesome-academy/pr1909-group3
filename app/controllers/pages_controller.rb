class PagesController < ApplicationController
  def index
    @product = Product.all.lates
  end
end
