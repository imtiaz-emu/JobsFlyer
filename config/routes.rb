Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :profiles
  resources :subscriptions
  resources :jobs do
    resources :applied_jobs do
      collection do
        get :hire_or_decline_job_applications
      end
    end
  end

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
  get '/dashboard/all_job_locations', to: 'dashboard#all_job_locations'
  get '/companies', to: 'dashboard#all_companies'
  get '/dashboard/follow_unfollow', to: 'dashboard#follow_unfollow'
  get '/advance-search', to: 'search#advance_search'
  get '/advance-search/results', to: 'search#advance_search_results'
  get 'resume-search', to: 'resume_search#index'
  get '/resume-search/results', to: 'resume_search#search_results'

  resources :search
  resources :users do
    get '/companies', to: 'companies#index'
    get '/my-job-applications', to: 'applied_jobs#index'
  end

  resources :companies, except: [:index, :destroy], path: ''

end
