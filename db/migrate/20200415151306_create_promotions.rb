class CreatePromotions < ActiveRecord::Migration[6.0]
  def change
    create_table :promotions do |t|
      t.integer :product_id
      t.integer :percent
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
