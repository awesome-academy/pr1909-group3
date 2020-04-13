class SetDefaultPermissionToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :permission, :integer, default: 3
  end
end
