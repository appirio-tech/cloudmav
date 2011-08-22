Codemav::Application.configure do
  
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'www.codemav.com',
    :user_name            => 'admin@codemav.com',
    :password             => 'pennyM00n',
    :authentication       => 'plain',
    :enable_starttls_auto => true  }

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"
  config.action_controller.asset_host = "http://www.codemav.com"

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  #config.middleware.use Rack::SslEnforcer, :only => "/login", :redirect_to => 'https://www.codemav.com'
  #config.middleware.use Rack::SslEnforcer, :only => "/users/sign_up", :redirect_to => 'https://www.codemav.com'
  
end
