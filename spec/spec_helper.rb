# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'geokit'
require 'score_it'
require 'virgil'
require 'json'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

VCR.config do |c|
  c.cassette_library_dir = 'specs/vcr_cassettes'
  c.stub_with :fakeweb
end

RSpec.configure do |config|
  config.mock_with :mocha

  config.before :each do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end
