Rails.application.routes.draw do
  apipie

  get '/', to: 'static_pages#home'
  root to: 'static_pages#home'

  get '/check-status', to: 'static_pages#check_status'
  get '/respuesta', to: 'static_pages#respuesta'
  get '/cuenta-activada/:id', to: 'static_pages#thanks', as: 'activation_success'
  get '/token-invalido', to: 'static_pages#invalid_activation_token'
  match "/ingresar" => redirect("#{ENV['CLIENT_URL']}/ingresar"), :as => :ingresar, via: :get

	scope module: "api" do
	  namespace :v1, path: "" do
	  	namespace :teachers do
	  		resources :schedules, only: [:update, :show, :index] do
	  			get 'session', on: :member
	  		end
	  		resources :bank_informations, only: [:update, :show]
	  	end
	  	namespace :students do
	  		resources :schedules, only: [:create, :update, :show, :index] do
	  			get 'session', on: :member
	  		end
	  	end
	    resources :users
	    resources :teachers, only: [:create, :update, :show, :index]
	    resources :students, only: [:create, :update, :show, :index]
	  	resources :account_activations, only: [:edit]
	  	resources :chats, only: [:index]
	  	resources	:messages, only: [:index, :create]
	    post 'session' => 'auths#authenticate'
	    delete 'session' => 'auths#logout'
      resources :epay_confirmations, only: [:create]
	  end
	end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
