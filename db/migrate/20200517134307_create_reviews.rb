class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :score
      t.string :content
      t.datetime :view_at

      t.timestamps
    end
  end
end
