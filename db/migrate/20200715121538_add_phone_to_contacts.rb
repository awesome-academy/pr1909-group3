class AddPhoneToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :phone, :string
  end
end
