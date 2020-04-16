class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.integer :product_id, null: false
      t.integer :percent, null: false, default: ""
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
