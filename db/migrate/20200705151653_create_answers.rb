class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :content
      t.references :question, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
