require 'rails'
require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'active_support/dependencies'
require 'active_support/concern'

autoload :Happening,   'that_just_happened/happening'

module ThatJustHappened
  autoload :Actor, 'that_just_happened/actor'
  autoload :Subject, 'that_just_happened/subject'
end