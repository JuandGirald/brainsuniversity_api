class Student < User
  before_create :set_role

  has_many :teacher_students
  has_many :teachers, through: :teacher_students
  has_many :student_coupons
  has_many :coupons, through: :student_coupons
  has_one :profile, inverse_of: :student
  has_many :schedules, inverse_of: :student

  accepts_nested_attributes_for :profile

  def add_coupon(coupon)
    self.coupons << coupon unless coupons.include?(coupon)
    self.save!
  end
  
  private
    def set_role
      self.role = 'student'
    end
end