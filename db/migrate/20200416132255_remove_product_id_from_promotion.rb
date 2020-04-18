class RemoveProductIdFromPromotion < ActiveRecord::Migration[6.0]
  def change
    remove_column :promotions, :product_id, :integer
  end
end
