Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "home#index"

  get "/about", as: :about, to: "about#index"
  get "/scorecard", as: :scorecard, to: "scorecard#index"

  get "scores/lookup"
end
