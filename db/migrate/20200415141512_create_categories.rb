class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :category_name
      t.string :code
      t.string :parent_code

      t.timestamps
    end
  end
end
