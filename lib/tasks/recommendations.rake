namespace :recommendations do    

  desc "build backlog item recommendations for profiles"
  task :backlog_items => :environment do
    BacklogItemRecommendationEngine.build_recommendations!
  end

end


