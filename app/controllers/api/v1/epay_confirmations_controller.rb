module Api::V1
  class EpayConfirmationsController < ApiController
    skip_before_action :authenticate_request, only: [:create]
    
    def create
      epay = EpayIntegration.new(params)
      if epay.validate_signature
        @order = Order.find_by(number: params[:x_id_factura])
        @order.process_payment(params)
        # process epay transaction information by order
        # epay.process_epay_transaction
        render json: { status: 'Thanks' }
      else
        render json: { error: 'Firma invalida' }, status: 401
      end
    end

  end
end
