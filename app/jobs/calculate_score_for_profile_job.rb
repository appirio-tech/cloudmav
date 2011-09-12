class CalculateScoreForProfileJob
  @queue = :scoring
  
  def self.perform(profile_id)
    profile = Profile.find(profile_id)
    
    calculate_score_for_git_hub(profile)
    
    profile.save
  end
  
  def self.calculate_score_for_git_hub(profile)
    return unless profile.git_hub_profile
    profile.earn(10, :coder_points, "for adding GitHub", profile.git_hub_profile)

    profile.git_hub_profile.repositories.each do |r|
      points = 1
      points = points + r.watchers * 0.1
      points = points + r.forks * 0.15
      points = points.round
      profile.earn(points, :coder_points, "for repository value", r)
    end
  end
end