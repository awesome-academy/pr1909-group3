class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :name
      t.text :authencode_app
      t.references :event, null: false, foreign_key: true
      t.boolean :is_admin

      t.timestamps
    end
  end
end
