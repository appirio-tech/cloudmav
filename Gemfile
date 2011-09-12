source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'json', '1.4.6'
gem 'jquery-rails'

# Database
gem "mongo"
gem "mongoid"
gem "bson_ext"
gem 'sqlite3' # cucumber yelled without this installed

# Authentication and Authorization
gem "devise"
gem "cancan"

# Server
gem "powify"

# View / UI
gem "haml"
gem "formtastic", "1.2.4"
gem "css3buttons", "1.0.1"

# 3rd Party Services
gem "gravtastic"

# Geolocation
gem "geokit"

# Async Processing
gem "resque", :require => 'resque/server'
gem "resque-status"

# Game mechanics
gem "badgeable"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :test do
  # rspec gems
  gem "rspec-rails"
  gem "factory_girl_rails"
  
  # cucumber gems
  gem "cucumber", "1.0.3"
  gem "cucumber-rails", "1.0.2"
  gem "database_cleaner" # cleans database for every scenario run. works with mongoid now
  gem "launchy" # allows 'show me the page' to launch a browser
    
  # mock web calls
  gem "vcr"
  gem "fakeweb"
end
