class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :address
      t.integer :status
      t.integer :subtotal
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
