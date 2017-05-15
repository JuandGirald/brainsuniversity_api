module Api::V1
	class AccountActivationsController < ApiController
		skip_before_action :authenticate_request, only: [:edit]
		
		def edit
	    user = User.find_by(email: params[:email])
	    if user && !user.activated? && user.authenticated?(:activation, params[:id])
	      user.activate
	      redirect_to activation_success_path(user)
	    else
	    	redirect_to token_invalido_path
	    end
	  end
	end
end