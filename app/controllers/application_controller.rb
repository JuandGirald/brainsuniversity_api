class ApplicationController < ActionController::API
	# Prevent errors with sorcery and rails-api
	include CanCan::ControllerAdditions
	
	def form_authenticity_token; end
	
	rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message, status: :unauthorized
  end

  protected 
    def pagination(paginated_array, per_page)
      { pagination: { per_page: per_page.to_i,
                      total_pages: paginated_array.total_pages,
                      total_objects: paginated_array.total_entries,
                      current_page: paginated_array.current_page
                    } }
    end
end
