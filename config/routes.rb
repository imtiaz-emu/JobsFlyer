Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :profiles
  resources :subscriptions
  resources :jobs

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'home/load_states'
  get '/companies/availability', to: 'companies#availability'
  get '/companies/new', to: 'companies#new'
  post '/companies', to: 'companies#create'
  get '/dashboard/calculate_price', to: 'dashboard#calculate_price'
  get '/dashboard/job_locations', to: 'dashboard#job_locations'
  get '/dashboard/skills', to: 'dashboard#skills'
  get '/companies', to: 'dashboard#all_companies'

  resources :search
  resources :users do
    get '/companies', to: 'companies#index'
  end

  resources :companies, except: [:index, :destroy], path: ''

end
