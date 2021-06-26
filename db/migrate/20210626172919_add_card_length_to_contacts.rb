class AddCardLengthToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :card_length, :integer
  end
end
