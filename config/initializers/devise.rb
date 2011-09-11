# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in DeviseMailer.
  config.mailer_sender = "no-reply@codemav.com"

  require 'devise/orm/mongoid'

  config.authentication_keys = [ :username ]
  config.case_insensitive_keys = [ :username ]
  config.strip_whitespace_keys = [ :username ]
  
  # increases performance for testing
  config.stretches = Rails.env.test? ? 1 : 10

  config.use_salt_as_remember_token = true

  config.reset_password_within = 2.hours
  
  config.sign_out_via = :delete
end
