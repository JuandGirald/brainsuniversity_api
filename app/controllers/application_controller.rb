class ApplicationController < ActionController::API
	# Prevent errors with sorcery and rails-api
	def form_authenticity_token; end
end
