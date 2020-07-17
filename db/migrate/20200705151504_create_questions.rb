class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :content
      t.references :event, foreign_key: true
      t.references :participant, foreign_key: true
      t.datetime :starts_on
      t.boolean :active, default: false
      t.boolean :stop_answer, default: false

      t.timestamps
    end
  end
end
