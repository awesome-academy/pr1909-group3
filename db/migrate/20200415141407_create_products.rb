class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name, null: false, default: ""
      t.text :detail, null: false, default: ""
      t.integer :price, null: false
      t.integer :quantity
      t.integer :category_id
      t.string :slug

      t.timestamps
    end
  end
end
