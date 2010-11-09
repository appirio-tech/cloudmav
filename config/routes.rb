Codemav::Application.routes.draw do

  devise_for :users do
    get "confirmation", :to => "devise/users#confirmation"
    get "login", :to => "devise/sessions#new"
    get 'logout', :to => "devise/sessions#destroy"
  end
  
  resources :profiles
  resources :stack_overflow_profiles
  resources :speaker_rate_profiles
  
  resources :people_searches
  
  root :to => "pages#home"
  
end
