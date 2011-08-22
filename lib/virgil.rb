require 'rails'
require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'active_support/dependencies'
require 'active_support/concern'

autoload :Knowledge,   'virgil/knowledge'

module Virgil
  autoload :Config, 'virgil/config'
  autoload :Dsl, 'virgil/dsl'
  autoload :Guidance, 'virgil/guidance'
  autoload :Teachable, 'virgil/teachable'
end

require 'virgil/railtie' if defined?(Rails)