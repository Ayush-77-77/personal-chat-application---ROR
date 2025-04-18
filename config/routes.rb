Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [ :show ]
  authenticated :user do
    root to: "conversations#index", as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :conversations, only: [ :index, :show, :create ] do
    resources :messages, only: [ :create ]
  end

  resources :contacts, except: [ :show ]














  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
end
