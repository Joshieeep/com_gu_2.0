Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  # get "passwords/edit"
  # get "passwords/update"
  # get "sessions/new"
  # get "sessions/create"
  # get "sessions/destroy"
  # get "main_pages/index"
  # get "registrations/new"
  # get "registrations/create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :registration
  resource :session
  resource :password_reset
  resource :password

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "main_pages#index"
end
