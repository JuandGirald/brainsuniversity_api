module Api::V1
	class AccountActivationsController < ApiController
		skip_before_action :authenticate_request, only: [:edit]

		def edit
	    user = User.find_by(email: params[:email])
	    if user && !user.activated? && user.authenticated?(:activation, params[:id])
	      user.activate
	      render json: user, serializer: NewUsersSerializer, status: :ok
	    else
	    	render json: "Invalid activation link", status: :unauthorized
	    end
	  end
	end
end