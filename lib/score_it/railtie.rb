
module ScoreIt
    class Railtie < Rails::Railtie
      config.to_prepare do
        puts "SCORE!"
      end
    end
end