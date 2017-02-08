class CreateBankInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_informations do |t|
      t.integer :teacher_id
      t.integer :owner_id, :limit => 8
      t.integer :account_number, :limit => 8
      t.string :bank_name
      t.string :account_type
      t.string :owner_name

      t.timestamps
    end
    add_index :bank_informations, :teacher_id
  end
end
