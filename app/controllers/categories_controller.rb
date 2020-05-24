class CategoriesController < ApplicationController
  def load_categories
    @categories = Category.all
    @cates_hash = {}
    @categories.each do |category|
      id = category.id
      name = category.category_name
      @cates_hash.store(name, id)
    end
  end
end
