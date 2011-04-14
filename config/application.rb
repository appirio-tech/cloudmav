require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Codemav
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => false
    end
    
    if config.respond_to?(:autoload_paths)
      config.autoload_paths += %W( #{config.root}/app/models/events ) 
      config.autoload_paths += %W( #{config.root}/lib ) 
      config.autoload_paths += %W( #{config.root}/lib/blog_syncers )
      config.autoload_paths += %W( #{config.root}/lib/apis )
      config.autoload_paths += %W( #{config.root}/lib/that_just_happened )
    end
    
    config.encoding = "utf-8"
    
    config.action_mailer.default_url_options = { :host => 'www.codemav.com' }

    config.filter_parameters += [:password, :password_confirmation]
  end
end
