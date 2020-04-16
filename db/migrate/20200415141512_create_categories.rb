class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false
      t.string :code, null: false
      t.string :parent_code

      t.timestamps
    end
  end
end
