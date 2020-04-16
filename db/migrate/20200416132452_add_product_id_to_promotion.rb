class AddProductIdToPromotion < ActiveRecord::Migration[6.0]
  def change
    add_column :promotions, :product_id, :integer
    add_index :promotions, :product_id
  end
end
