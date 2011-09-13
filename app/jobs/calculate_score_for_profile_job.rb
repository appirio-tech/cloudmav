class CalculateScoreForProfileJob
  @queue = :scoring
  
  def self.perform(profile_id)
    profile = Profile.find(profile_id)
    profile.scorings.destroy_all
    
    calculate_score_for_git_hub(profile)
    calculate_score_for_bitbucket(profile)
    calculate_score_for_coder_wall(profile)
    
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
  
  def self.calculate_score_for_bitbucket(profile)
    return unless profile.bitbucket_profile
    profile.earn(10, :coder_points, "for adding Bitbucket", profile.bitbucket_profile)    
  end
  
  def self.calculate_score_for_coder_wall(profile)
    return unless profile.coder_wall_profile
    points = profile.coder_wall_profile.badges_count * 5
    profile.earn(10, :coder_points, "for adding CoderWall", profile.coder_wall_profile)
    profile.earn(points, :coder_points, "for CoderWall badges", profile.coder_wall_profile)    
  end
  
end