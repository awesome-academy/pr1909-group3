class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.references :event, foreign_key: true
      t.string :file_data

      t.timestamps
    end
  end
end
