class AddIntendToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :intend, :integer
  end
end
