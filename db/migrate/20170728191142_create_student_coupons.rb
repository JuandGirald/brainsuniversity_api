class CreateStudentCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :student_coupons do |t|
      t.belongs_to :student, index: true
      t.belongs_to :coupon, index: true
      t.boolean :redeemed, default: false

      t.timestamps
    end
  end
end
