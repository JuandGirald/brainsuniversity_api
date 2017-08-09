class StudentCoupon < ApplicationRecord
  belongs_to :student
  belongs_to :coupon
end
