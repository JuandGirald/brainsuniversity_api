class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.date :dob
      t.string :phone
      t.string :address
      t.string :gender
      t.string :city
      t.string :country
      t.string :university
      t.string :level
      t.text   :about
      t.integer :rate 
      t.belongs_to :user, index: true, unique: true, foreign_key: true

      t.timestamps
    end
  end
end
