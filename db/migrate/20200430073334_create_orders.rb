class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :total_price
      t.integer :state, default: 0
      t.string :phone
      t.string :address
      t.string :reciever_name

      t.timestamps
    end
  end
end
