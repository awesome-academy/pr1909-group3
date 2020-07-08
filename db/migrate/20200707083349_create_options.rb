class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.text :content
      t.references :poll, foreign_key: true
      t.float :vote_value

      t.timestamps
    end
  end
end
