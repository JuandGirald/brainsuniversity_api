module Api::V1
	class AccountActivationsController < ApiController
		def edit
	    user = User.find_by(email: params[:email])
	    if user && !user.activated? && user.authenticated?(:activation, params[:id])
	      user.activate
	      render json: @users, status: :ok
	    else
	    	render json: "Invalid activation link", status: :unauthorized
	    end
	  end
	end
end