module Api::V1
  class EpayConfirmationsController < ApiController
    skip_before_action :authenticate_request, only: [:create]
    
    def create
      epay = EpayIntegration.new(params)
      if epay.validate_signature
        # process epay transaction information by order
        # epay.process_epay_transaction
        render json: { status: 'Thanks' }
      else
        render json: { error: 'Firma invalida' }, status: 401
      end
    end

  end
end
