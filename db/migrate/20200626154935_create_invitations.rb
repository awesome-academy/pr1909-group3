class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :event, foreign_key: true
      t.string :email
      t.string :name
      t.boolean :confirm, default: false
      t.text :invitation_digest
      t.integer :participant_id

      t.timestamps
    end
  end
end
