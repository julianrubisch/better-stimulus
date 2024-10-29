Rails.application.routes.draw do
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
