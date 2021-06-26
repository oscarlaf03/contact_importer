class AddCreditCardDigitsToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :card_digits, :string
  end
end
