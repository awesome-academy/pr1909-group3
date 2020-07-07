class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :option, foreign_key: true
      t.references :participant, foreign_key: true

      t.timestamps
    end
  end
end
