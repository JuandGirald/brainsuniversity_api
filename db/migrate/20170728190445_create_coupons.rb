class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.text :description
      t.integer :limit
      t.integer :amount
      t.date :valid_from
      t.date :valid_until

      t.timestamps
    end
  end
end
