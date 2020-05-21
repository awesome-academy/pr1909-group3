class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.integer :unit_price
      t.integer :total_price
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
