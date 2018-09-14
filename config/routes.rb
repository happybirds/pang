require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin,
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: {
      sessions: 'admin/sessions'
    }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # mount Crono::Web, at: '/crono'
   mount Sidekiq::Web => '/sidekiq'
	 root 'lists#index'
	 get 'distance' => 'paths#distance'
   get 'change' => 'paths#change'
	 get 'path' => 'paths#index'

	 resources :articles

	 namespace :admin do
	    root 'home#index'
	    resources :articles
  	  resources :schedules
      resources :boards
	 end

end
