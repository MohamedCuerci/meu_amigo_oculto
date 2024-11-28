Rails.application.routes.draw do
  resources :assignments
  
  resources :secret_santas do
    resources :participants, only: [:create, :destroy] do
      collection do
        post :join # Define um caminho como /secret_santas/:secret_santa_id/participants/join
      end
    end
  end
  

  resources :user_preferences
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
