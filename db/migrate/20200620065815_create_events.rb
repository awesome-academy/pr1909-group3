class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starts_on
      t.datetime :ends_on
      t.text :description
      t.string :degit_code
      t.integer :privacy
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
