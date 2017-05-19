class Change < ActiveRecord::Migration[5.0]
  def change
    change_column  :bank_informations, :account_number, :string
  end
end
