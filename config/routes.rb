Rails.application.routes.draw do
  resources :teams
  get "/calender", to: "calender#index"
  get "/search", to: "search#index"
  get "/read_notifications", to: "read_notifications#read_all"
  devise_for :users
  resources :dashboard, only: [:index]
  authenticate :user, ->(user) { user.organisation_owner? } do
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    resources :organisation_users do
      member do
        post "/change_roles", to: "organisation_users#change_role"
      end
    end
  end
  
  authenticate :user, ->(user) { user.admin? } do
    mount GoodJob::Engine => "good_job"
    namespace :admin do
      resources :dashboard
    end
  end

  resources :notifications, only: [:index]
  resources :projects do
    resources :tasks
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
