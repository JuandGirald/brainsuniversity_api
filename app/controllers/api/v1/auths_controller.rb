module Api::V1
	class AuthsController < ApiController
		include Api::V1::AuthDoc

		skip_before_action :authenticate_request, only: [:authenticate]

	  def authenticate
	    command = AuthenticateUser.call(params[:username], params[:password])

	    if command.success?
	    	user = User.find_by_email(params[:username])
	    	user.represent_user_with_token(command.result)
	    	render json: { token: user.token, user_id: user.id }
	    else
	      render json: { error: command.errors }, status: :unauthorized
	    end
	  end

		def logout
		  @current_user.delete_token
		  render json: { status: "Logged out" }
		end
	end
end
