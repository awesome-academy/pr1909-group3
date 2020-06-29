class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.references :event, foreign_key: true
      t.datetime :starts_on
      t.boolean :active

      t.timestamps
    end
  end
end
