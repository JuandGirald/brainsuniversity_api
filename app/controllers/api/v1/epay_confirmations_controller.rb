module Api::V1
  class EpayConfirmationsController < ApiController
    skip_before_action :authenticate_request, only: [:create]
    
    def create
      puts params[:x_response]
    end
  end
end