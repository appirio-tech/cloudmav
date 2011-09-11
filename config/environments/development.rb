require 'score_it'
require 'virgil'

Codemav::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'www.codemav.com',
    :user_name            => 'rookieone@gmail.com',
    :password             => 'iluv2nap',
    :authentication       => 'plain',
    :enable_starttls_auto => true  }
    
  PAPERCLIP_CONFIG = {}
  
  CarrierWave.configure do |config|
    config.s3_access_key_id = 'AKIAIG7WF7PZP7OV4QBQ'
    config.s3_secret_access_key = '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'
    config.s3_bucket = 'codemav_test'
  end
  
end

