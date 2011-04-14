Codemav::Application.routes.draw do
  match 'beta' => "beta#login", :as =>:beta_login, :via=>[:get, :post]
  
  match 'api_documentation' => 'pages#api_documentation', :as => :api_documentation
  match 'whats_up' => 'activities#index', :as => :whats_up

  resources :contacts
  match 'contact' => 'contacts#new', :as => :contact

  resources :tags
  resources :activities
  
  match '/:username/speaker_bio' => "speaker_bio#show", :as => :speaker_bio
  match '/:username/speaker_bio/edit' => "speaker_bio#edit", :as => :edit_speaker_bio, :method => :get
  match '/:username/speaker_bio/update' => "speaker_bio#update", :as => :update_speaker_bio, :method => :put
  resources :talks do
    resources :presentations
  end
  resources :projects
  resources :technologies

  resources :blogs do
    resources :posts
  end

  resources :linkedin_profiles do
    collection do
      get :callback
      post :confirm
    end
  end
  resources :jobs
  # match '/linkedin/callback' => "linkedin_profiles#callback", :as => :linkedin_callback
  
  resources :speaker_rate_profiles
  resources :slide_share_profiles
  resources :git_hub_profiles
  resources :projects
  
  resources :scoreboards do
    collection do
      get "stack_overflow"
    end
  end
  resources :people_searches
  resources :talk_searches
  resources :company_searches
  
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

  namespace :widget do
    match "/:username" => "profiles#show", :as => :profile
  end
  
  resources :profiles do
    resources :twitter_profiles
    resources :stack_overflow_profiles
    resources :events
    resources :followings
    resources :widgets
    collection do
      post :search
    end
  end

  match "/:username" => "profiles#show", :as => :profile
  match "/:username/experience" => "profiles#experience", :as => :profile_experience
  match "/:username/code" => "profiles#code", :as => :profile_code
  match "/:username/writing" => "profiles#writing", :as => :profile_writing
  match "/:username/speaking" => "profiles#speaking", :as => :profile_speaking
  match "/:username/social" => "profiles#social", :as => :profile_social
  match "/:username/edit" => "profiles#edit", :as => :edit_profile
  match "/:username/update" => "profiles#update", :as => :update_profile, :method => :put
  
  root :to => "pages#home"
end
