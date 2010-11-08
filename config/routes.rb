Codemav::Application.routes.draw do

  devise_for :users do
    get "confirmation", :to => "devise/users#confirmation"
    get "login", :to => "devise/sessions#new"
    get 'logout', :to => "devise/sessions#destroy"
  end
  
  resources :profiles
  resources :stack_overflow_profiles
  
  root :to => "pages#home"
  
end
