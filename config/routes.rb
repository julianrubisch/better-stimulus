Rails.application.routes.draw do
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  # get  "sign_up", to: "registrations#new"
  # post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  # resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    # resource :password_reset,     only: [:new, :edit, :create, :update]
  end
  namespace :authentications do
    resources :events, only: :index
  end
  get  "/auth/failure",            to: "sessions/omniauth#failure"
  get  "/auth/:provider/callback", to: "sessions/omniauth#create"
  post "/auth/:provider/callback", to: "sessions/omniauth#create"

  get "templates/:category/:recipe", to: "templates#show", as: :template, defaults: {format: "txt"}

  sitepress_pages
  sitepress_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # TODO authenticate the 3 below
  # mount SolidErrors::Engine, at: "/errors"
  # mount Litestream::Engine, at: "/litestream"
  # mount MissionControl::Jobs::Engine, at: "/jobs"

  # Defines the root path route ("/")
  # root "posts#index"
end
