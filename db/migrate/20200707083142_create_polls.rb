class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title
      t.text :content
      t.boolean :active, default: false
      t.string :stop_vote, default: false
      t.references :event, foreign_key: true
      t.integer :multi_vote, default: 1
      t.datetime :starts_on

      t.timestamps
    end
  end
end
