class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :state
      t.datetime :transaction_date
      t.integer :order_id
      t.string :response_code
      t.decimal :amount

      t.timestamps
    end
  end
end
