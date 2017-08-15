class Coupon < ApplicationRecord
  has_many :student_coupons
  has_many :students, through: :student_coupons
  has_many :schedules, through: :student_coupons

  validates :code, uniqueness: true
  validates_presence_of :code, :coupon_type, :description, :amount,
                        :valid_from, :valid_until

  scope :valid, -> { where("valid_from <= ? AND valid_until >= ?", Date.today, Date.today) }

  enum coupon_type: { time: '1', 
                      percentage: '2',
                      amount: '3',
                    }

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
