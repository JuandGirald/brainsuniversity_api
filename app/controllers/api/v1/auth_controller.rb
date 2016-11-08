module Api::V1
	class AuthController < ApiController
		include Sorcery::Controller

		skip_before_filter :authenticate!, only: [:authenticate]
		
		def authenticate
		  user = login(params[:username], params[:password])
		  if user 
		    # Destroy sorcery session, unnecessary for the api
		    reset_session
		    user.represent_user_with_token
		    token = user.token
		    render json: { status: "OK",  auth_token: token, user_id: user.id }
		  else
		    render json: { status: "Error" }, status: :unauthorized
		  end
		end

		def logout
		  current_user.delete_token
		  render json: { status: "Logged out" }
		end
	end
end