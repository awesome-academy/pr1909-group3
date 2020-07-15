class AddIntendToPolls < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :intend, :integer
  end
end
