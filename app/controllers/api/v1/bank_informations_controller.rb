module Api::V1
	class BankInformationsController < ApiController
		load_and_authorize_resource
		load_and_authorize_resource :bank_information, :through => :teacher

		before_action :set_user

		def show
			render json: @user, serializer: TeacherBankSerializer
		end

		def update
			@bank_information = @user.bank_information
			if @bank_information.update_attributes(bank_information_params)
				@user.complete!
	      render json: @user, serializer: TeacherBankSerializer
	    else
	      render json: @user.errors, status: :unprocessable_entity
	    end
		end

		private
			def set_user
				@user = Teacher.find(params[:teacher_id])
			end

			def bank_information_params
				params.require(:bank_information).permit(:id, :owner_id, :account_number, 
																								:bank_name, :account_type, 
																								:owner_name, :teacher_id)
			end
	end
end