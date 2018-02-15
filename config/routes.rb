Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "home#index"

  get "/about", as: :about, to: "about#index"

  resources :scores, only: :index do
    get "lookup", on: :collection
  end
end
