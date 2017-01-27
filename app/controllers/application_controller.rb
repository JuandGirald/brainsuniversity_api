class ApplicationController < ActionController::API
	# Prevent errors with sorcery and rails-api
	def form_authenticity_token; end
	include CanCan::ControllerAdditions

	rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message, status: :unauthorized
  end
end
