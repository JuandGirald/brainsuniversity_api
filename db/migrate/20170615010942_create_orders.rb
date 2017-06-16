class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :schedule_id
      t.string :number
      t.decimal :total
      t.string :hour
      t.string :title
      t.text :description
      t.datetime :completed_at
      t.string :currency
      t.string :status, default: "3",   null: false

      t.timestamps
    end
  end
end
