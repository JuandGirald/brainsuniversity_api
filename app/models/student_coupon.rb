class StudentCoupon < ApplicationRecord
  belongs_to :student
  belongs_to :coupon
  belongs_to :schedule

  scope :find_student_coupon, -> (coupon_id) { find_by("coupon_id = ?", coupon_id) } 
end
