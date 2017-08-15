class CouponSerializer < ActiveModel::Serializer
  attributes :id, :code, :description, :valid_from, :valid_until, :redeemed

  def redeemed
    scope.student_coupons.find_by(coupon_id: object.id).redeemed
  end
end