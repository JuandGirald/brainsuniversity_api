class ChangeStringToTextInSubjectsUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :subjects

    add_column  :users, :subjects, :text, array: true, default: []
  end
end
