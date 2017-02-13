Rails.application.routes.draw do
  apipie
	scope module: "api" do
	  namespace :v1, path: "" do
	  	namespace :teachers do
	  		resources :schedules, only: [:update, :show, :index]
	  		resources :bank_informations, only: [:update, :show]
	  	end
	  	namespace :students do
	  		resources :schedules, only: [:create, :update, :show, :index]
	  	end
	    resources :users
	    resources :teachers, only: [:create, :update, :show, :index]
	    resources :students, only: [:create, :update, :show]
	  	resources :account_activations, only: [:edit]
	    post 'session' => 'auths#authenticate'
	    delete 'session' => 'auths#logout'
	  end
	end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
