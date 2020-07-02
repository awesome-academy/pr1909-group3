class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.references :event, null: false, foreign_key: true
      t.string :email
      t.string :name
      t.boolean :confirm
      t.text :invitation_digest
      t.integer :participant_id

      t.timestamps
    end
  end
end
