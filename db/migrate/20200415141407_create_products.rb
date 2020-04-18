class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name, null: false, default: ""
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false, default: 1
      t.integer :category_id, nul: false
      t.string :slug

      t.timestamps
    end
  end
end
