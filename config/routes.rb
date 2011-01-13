Codemav::Application.routes.draw do
  match 'beta' => "beta#login", :as =>:beta_login, :via=>[:get, :post]
  
  match 'api_documentation' => 'pages#api_documentation', :as => :api_documentation
  match 'whats_up' => 'activities#index', :as => :whats_up
  
  resources :activities
  
  resources :talks do
    resources :presentations
  end
  resources :projects
  
  resources :blogs do
    resources :posts
  end

  resources :speaker_rate_profiles
  resources :slide_share_profiles
  resources :stack_overflow_profiles
  resources :git_hub_profiles
  resources :projects
  
  resources :scoreboards do
    collection do
      get "stack_overflow"
    end
  end
  resources :people_searches
  resources :talk_searches
  
  resources :companies
  resources :user_groups do
    resources :meetings
  end
  
  namespace :api do
    resources :profiles
  end
  
  devise_for :users do
    get "confirmation", :to => "devise/users#confirmation"
    get "login", :to => "devise/sessions#new"
    get 'logout', :to => "devise/sessions#destroy"
  end
  
  resource :profile
  match "/:username" => "profiles#show", :as => :profile
  match "/:username/experience" => "profiles#experience", :as => :profile_experience
  match "/:username/code" => "profiles#code", :as => :profile_code
  match "/:username/writing" => "profiles#writing", :as => :profile_writing
  match "/:username/speaking" => "profiles#speaking", :as => :profile_speaking
  
  root :to => "pages#home"
end
