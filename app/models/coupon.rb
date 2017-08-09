class Coupon < ApplicationRecord
  has_many :student_coupons
  has_many :students, through: :student_coupons

  scope :valid, -> { where("valid_until <= ? AND valid_until >= ?", Date.today, Date.today) }

  def valid_date?
    valid_until >= Date.today 
  end

  def limit?
    limit == 0
  end

  def decrease
    self.limit -= 1
    self.save!
  end
end
