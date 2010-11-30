require 'rails'
require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'active_support/dependencies'
require 'active_support/concern'

autoload :Scoring,   'score_it/scoring'

module ScoreIt
  autoload :Config, 'score_it/config'
  autoload :Dsl, 'score_it/dsl'
  autoload :Score, 'score_it/score'
  autoload :Subject, 'score_it/subject'
end

require 'score_it/railtie' if defined?(Rails)