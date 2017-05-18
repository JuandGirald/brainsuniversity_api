module Api::V1
  class Teachers::BankInformationsController < ApiController
    include ErrorSerializer
    load_and_authorize_resource
    load_and_authorize_resource :bank_information, :through => :teacher

    before_action :set_user, :set_bank_information

    def show
      render json: @bank_information, serializer: BankSerializer
    end

    def update
      @bank_information = @user.bank_information
      if @bank_information.update_attributes(bank_information_params)
        @user.complete!
        render json: @bank_information, serializer: BankSerializer
      else
        render json: ErrorSerializer.serialize(@user.bank_information.errors), status: :unprocessable_entity
      end
    end

    private
      def set_user
        @user = current_user
      end

      def set_bank_information
        @bank_information = BankInformation.find(params[:id])
      end

      def bank_information_params
        params.require(:bank_information).permit(:id, :owner_id, :account_number, 
                                                :bank_name, :account_type, 
                                                :owner_name, :teacher_id)
      end
  end
end