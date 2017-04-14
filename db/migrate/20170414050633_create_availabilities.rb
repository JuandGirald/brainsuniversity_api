class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.integer :teacher_id
      t.string :morning, array: true, default: '{}'
      t.string :afternoon, array: true, default: '{}'
      t.string :evening, array: true, default: '{}'
      t.string :night, array: true, default: '{}'

      t.timestamps
    end
  end
end
