class AddIntendToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :intend, :integer
  end
end
