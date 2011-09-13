Codemav::Application.routes.draw do
  namespace "api/v1", :as => :api do
    resources :profiles do
      member do
        get :tags
      end
    end
  end
  
  devise_for :users do
    get "confirmation", :to => "devise/users#confirmation"
    get "login", :to => "devise/sessions#new"
    get 'logout', :to => "devise/sessions#destroy"
  end
  
  resources :profiles do
    resources :autodiscovers
    resources :git_hub_profiles
    resources :bitbucket_profiles
    resources :coder_wall_profiles
    resources :stack_overflow_profiles
    resources :speaker_rate_profiles
    resources :slide_share_profiles
    resources :followings
    resources :blogs
    resources :talks do
      resource :link_to_speaker_rate do
        member do
          get :refresh
        end
      end
      resource :link_to_slide_share do
        member do
          get :refresh
        end
      end
    end
  end
  
  resources :companies
  
  resources :contacts
  match 'contact' => 'contacts#new', :as => :contact
  
  mount Resque::Server, :at => "/resque"  
  
  match "/:username" => "profiles#show", :as => :profile
  match "/:username/experience" => "profiles#experience", :as => :profile_experience
  match "/:username/code" => "profiles#code", :as => :profile_code
  match "/:username/knowledge" => "profiles#knowledge", :as => :profile_knowledge
  match "/:username/writing" => "profiles#writing", :as => :profile_writing
  match "/:username/speaking" => "profiles#speaking", :as => :profile_speaking
  match "/:username/social" => "profiles#social", :as => :profile_social
  
  root :to => "pages#home"
end
