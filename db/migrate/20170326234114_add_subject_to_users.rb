class AddSubjectToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :subjects, :string, array: true, default: '{}'
  end
end
