class AddCategoryIdToProduct < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :category_id
  end
end
