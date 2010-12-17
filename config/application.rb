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
      config.autoload_paths += %W( #{config.root}/lib ) 
      config.autoload_paths += %W( #{config.root}/lib/blog_syncers )
    end
    
    config.encoding = "utf-8"
    
    config.action_mailer.default_url_options = { :host => 'localhost:3000' }

    config.filter_parameters += [:password, :password_confirmation]
    
    # config.to_prepare do
    #   ScoreIt::Dsl.class_eval(File.read("#{Rails.root}/lib/scores.rb"))
    # end
  end
end
