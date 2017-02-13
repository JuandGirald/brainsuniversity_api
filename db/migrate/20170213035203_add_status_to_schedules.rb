class AddStatusToSchedules < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :status, :string
  end
end
