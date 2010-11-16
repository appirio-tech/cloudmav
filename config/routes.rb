Codemav::Application.routes.draw do

  devise_for :users do
    get "confirmation", :to => "devise/users#confirmation"
    get "login", :to => "devise/sessions#new"
    get 'logout', :to => "devise/sessions#destroy"
  end
  
  resources :profiles
  resources :stack_overflow_profiles do
    collection do
      get "synch"
    end
  end
  resources :speaker_rate_profiles
  resources :git_hub_profiles do
    collection do
      get "synch"
    end
  end
  
  resources :scoreboards do
    collection do
      get "stack_overflow"
    end
  end
  resources :people_searches
  
  resources :companies
  resources :user_groups
  
  namespace :api do
    resources :profiles
  end
  
  root :to => "pages#home"
  
end
