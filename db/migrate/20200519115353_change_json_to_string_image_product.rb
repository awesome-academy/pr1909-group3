class ChangeJsonToStringImageProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :images, :image
    change_column :products, :image, :string
  end
end
