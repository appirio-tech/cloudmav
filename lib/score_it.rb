require 'rails'
require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'active_support/dependencies'
require 'active_support/concern'

autoload :Scoring,   'score_it/scoring'

module ScoreIt

end

require 'score_it/railtie' if defined?(Rails)