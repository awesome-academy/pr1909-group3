class CategoriesController < ApplicationController
  before_action :find_category

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = "notfound"
    redirect_to root_path
  end
end
