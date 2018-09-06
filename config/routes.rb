Rails.application.routes.draw do
  devise_for :admin,
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: {
      sessions: 'admin/sessions'
    }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	 root 'lists#index'
	 get 'distance' => 'paths#distance'
	 get 'path' => 'paths#index'

	 resources :articles

	 namespace :admin do
	    root 'home#index'
	    resources :articles
  	  resources :schedules
      resources :boards
	 end

end
