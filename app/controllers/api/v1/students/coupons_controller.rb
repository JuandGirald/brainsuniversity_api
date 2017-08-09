module Api::V1
  class Students::CouponsController < ApiController

    # retreive all active curren user coupons for current_user
    def index
      @coupons = current_user.coupons.valid  

      render json: @coupons
    end

    def apply
      command = ManageCoupons.call(params[:code], current_user) if params[:code]
      
      if command.success?
        coupon = Coupon.find_by(code: params[:code].upcase)
        
        current_user.add_coupon(coupon)
        coupon.decrease

        render json: { coupons: "Cupón creado con éxito", status: :success }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end