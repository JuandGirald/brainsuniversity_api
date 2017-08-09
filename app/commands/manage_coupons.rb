class ManageCoupons
  prepend SimpleCommand

  def initialize(code, user)
    @code = code
    @user = user
  end

  def call
    check_coupon
  end

  private

    attr_reader :code, :user

    def check_coupon
      coupon = Coupon.find_by(code: code.upcase)

      if coupon 
        return coupon if !user.coupons.include?(coupon) && coupon.valid_date? && !coupon.limit?
        errors.add :coupon, 'Este código ya fue utilizado por este usuario' if user.coupons.include?(coupon)
        errors.add :coupon, 'Este código ya expiró' if !coupon.valid_date?
        errors.add :coupon, 'Este código ya alcanzó el límite de usos' if coupon.limit?
      else
        errors.add :coupon, 'No existe ninguna promoción con este código'
      end
    end
end