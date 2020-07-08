class AddIntendToPolls < ActiveRecord::Migration[6.0]
  def change
    add_column :polls, :intend, :integer
  end
end
