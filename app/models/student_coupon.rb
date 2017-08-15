class StudentCoupon < ApplicationRecord
  belongs_to :student
  belongs_to :coupon
  belongs_to :schedule

  scope :valid, -> { where("valid_from <= ? AND valid_until >= ? AND redeemed = ?", Date.today, Date.today, false) }
  scope :find_student_coupon, -> (coupon_id) { find_by("coupon_id = ?", coupon_id) } 
end
