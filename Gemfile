source 'http://rubygems.org'

gem 'rails', '3.1.10'
gem 'rake', '0.8.7'
gem 'json', '1.4.6'
gem 'jquery-rails'

# Database
gem "mongo"
gem "mongoid", '~> 2'
gem "bson_ext"

gem "kaminari" # for paging
group :production do
  gem 'pg'
end
group :test do
  gem 'sqlite3-ruby'
end

# Authentication and Authorization
gem "devise"
gem "cancan"

# Server
gem "powify", '0.8.5'
gem "foreman"
gem "thin"

# View / UI
gem "haml"
gem "formtastic", "1.2.4"
gem "css3buttons", "1.0.1"
gem 'modular-scale'

# 3rd Party Services
gem "gravtastic"

# Rss
gem "simple-rss", "1.2.3"
gem "escape_utils", "0.2.3"

# Api Gems
gem "httparty"
gem "bitbucket_api"
gem "stack_overflow"
gem "speaker_rate"
gem "slide_share"
gem "linkedin"
gem "twitter"

# Geolocation
gem "geokit"

# Async Processing
gem "resque", :require => 'resque/server'
gem "resque-status"
gem "resque-scheduler"

# Game mechanics
gem "badgeable"

# Search
gem "sunspot", "1.2.1"
gem "sunspot_rails", "1.2.1"

# Friendly Url
gem "has_permalink"

# CodeMav Api
gem 'crack'
gem "rabl", "0.3.0"

# Attach images to models and store in the s3 cloud
gem 'fog', "0.11.0"
gem 'rmagick', "2.13.1"
gem "carrierwave", "0.5.7"
gem 'carrierwave-mongoid', "0.1.0", :require => 'carrierwave/mongoid'

# Exceptions
gem "airbrake"

# Email
gem "sendgrid"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'bourbon'
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
