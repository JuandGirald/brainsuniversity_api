module Api::V1
	class ApiController < ApplicationController
		before_action :authenticate!
		
		def validate_token!
		  begin
		    TokenProvider.valid?(token)
		  rescue
		    error!('Unauthorized', 401)
		  end
		end

		# Authenticate the user with token based authentication
		def authenticate!
		  begin
		    payload, header = TokenProvider.valid?(token)
		    @current_user = User.find_by(id: payload['user_id'])
		  rescue
		    render_unauthorized
		  end
		end

		def current_user
		  @current_user ||= authenticate!
		end

		def token
		  request.headers['Authorization'].split(' ').last
		end

		def render_unauthorized(realm = "Application")
		  self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
		  render json: 'Bad credentials', status: :unauthorized
		end
	end
end