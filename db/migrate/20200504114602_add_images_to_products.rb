class AddImagesToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :images, :json
  end
end
