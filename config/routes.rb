Rails.application.routes.draw do
  apipie
	scope module: "api" do
	  namespace :v1, path: "" do
	    resources :users
	    resources :teachers, only: [:create, :update, :show]
	    resources :students, only: [:create, :update, :show]
	    post 'session' => 'auth#authenticate'
	    delete 'session' => 'auth#logout'
	  end
	end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
