Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :profiles

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'home/load_states'
end
