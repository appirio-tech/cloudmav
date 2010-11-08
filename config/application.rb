require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Codemav
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => false
    end
    
    config.autoload_paths += %W( #{config.root}/lib ) if config.respond_to?(:autoload_paths)
    
    config.encoding = "utf-8"
    
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }

    config.filter_parameters += [:password, :password_confirmation]
  end
end
