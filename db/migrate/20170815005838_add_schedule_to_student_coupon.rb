class AddScheduleToStudentCoupon < ActiveRecord::Migration[5.0]
  def change
    add_column :student_coupons, :schedule_id, :integer
  end
end
