class AddVotesCountToOptions < ActiveRecord::Migration[6.0]
  def self.up
    add_column :options, :votes_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :options, :votes_count
  end
end
