Codemav::Application.routes.draw do
  devise_for :users do
    get "confirmation", :to => "devise/users#confirmation"
    get "login", :to => "devise/sessions#new"
    get 'logout', :to => "devise/sessions#destroy"
  end
  
  resources :profiles do
    resources :autodiscovers
    resources :git_hub_profiles
  end
  
  match "/:username" => "profiles#show", :as => :profile
  match "/:username/experience" => "profiles#experience", :as => :profile_experience
  match "/:username/code" => "profiles#code", :as => :profile_code
  match "/:username/knowledge" => "profiles#knowledge", :as => :profile_knowledge
  match "/:username/writing" => "profiles#writing", :as => :profile_writing
  match "/:username/speaking" => "profiles#speaking", :as => :profile_speaking
  match "/:username/social" => "profiles#social", :as => :profile_social
    
  root :to => "pages#home"
end
