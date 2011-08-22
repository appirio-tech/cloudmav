
module ScoreIt
  class Railtie < Rails::Railtie
    initializer "score_it.assign_badge_definitions_file" do
      ScoreIt::Config.score_definitions = Pathname.new("#{Rails.root}/lib/scores.rb")
    end

    config.to_prepare do
      ScoreIt::Config.score_definitions = Pathname.new("#{Rails.root}/lib/scores.rb")
      ScoreIt::Dsl.class_eval(File.read(ScoreIt::Config.score_definitions))
    end
  end
end