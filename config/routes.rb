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
      resources :nutritions
      resources :beans
      resources :bean_nutritions
	 end



  namespace :api do
    namespace :v1 do
      get 'r1daydir1' => 'paths#r1daydir1'
      get 'r1daydir2' => 'paths#r1daydir2'
      get 'r1eveningdir1' => 'paths#r1eveningdir1'
      get 'r1eveningdir2' => 'paths#r1eveningdir2'
      get 'r2daydir1' => 'paths#r2daydir1'
      get 'r3daydir1' => 'paths#r3daydir1'
      get 'timer' =>'timer#timer'

      get 'count' => 'paths#count'
      get 'bridge' => 'bridge#index'
      get 'airport' => 'airport#index'
      get 'ferry' => 'ferry#index'
      get '/garbages/detail'=> 'garbages#detail'
      get '/garbages/address'=> 'garbages#address'

    end
  end
end
