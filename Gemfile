source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'rake', '0.8.7'
gem 'json', '1.4.6'
gem 'jquery-rails'

# Database
gem "mongo"
gem "mongoid"
gem "bson_ext"
gem 'sqlite3' # cucumber yelled without this installed
group :production do
  gem 'pg'
end

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

# Rss
gem "simple-rss", "1.2.3"
gem "escape_utils", "0.2.3"

# Api Gems
gem "httparty", "0.7.8"
gem "bitbucket_api", "0.0.1"
gem "stack_overflow", "0.0.7"
gem "speaker_rate", "0.0.5"
gem "slide_share", "0.0.3"
gem "linkedin", "0.3.1"
gem "twitter", "1.6.1"

# Geolocation
gem "geokit"

# Async Processing
gem "resque", :require => 'resque/server'
gem "resque-status"

# Game mechanics
gem "badgeable"

# Search
gem "sunspot", "1.2.1"
gem "sunspot_rails", "1.2.1"

# Friendly Url
gem "has_permalink"

# CodeMav Api
gem "rabl", "0.3.0"

# Attach images to models and store in the s3 cloud
gem 'fog', "0.11.0"
gem 'rmagick', "2.13.1"
gem "carrierwave", "0.5.7"
gem 'carrierwave-mongoid', "0.1.0", :require => 'carrierwave/mongoid'

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
  
  # mocks & stubs
  gem "mocha", "0.9.12"
  
  # mock web calls
  gem "vcr"
  gem "fakeweb"
end
