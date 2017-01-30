class ApplicationController < ActionController::API
	# Prevent errors with sorcery and rails-api
	include CanCan::ControllerAdditions
	
	def form_authenticity_token; end
	
	rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message, status: :unauthorized
  end
end
