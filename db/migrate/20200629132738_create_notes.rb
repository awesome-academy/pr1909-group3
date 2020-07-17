class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :event, foreign_key: true
      t.datetime :starts_on
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
