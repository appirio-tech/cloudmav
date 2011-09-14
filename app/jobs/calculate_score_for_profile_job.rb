class CalculateScoreForProfileJob
  @queue = :scoring
  
  def self.perform(profile_id)
    profile = Profile.find(profile_id)
    profile.scorings.destroy_all
    
    # knowledge
    calculate_score_for_stack_overflow(profile)
    
    # coder
    calculate_score_for_git_hub(profile)
    calculate_score_for_bitbucket(profile)
    calculate_score_for_coder_wall(profile)
    
    # speaker
    calculate_score_for_speaker_rate(profile)
    calculate_score_for_slide_share(profile)
    calculate_score_for_talks(profile)
    
    # writer
    calculate_score_for_blogs(profile)
    
    # social
    calculate_score_for_twitter(profile)
    
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
  
  def self.calculate_score_for_stack_overflow(profile)
    return unless profile.stack_overflow_profile
    profile.earn(10, :knowledge_points, "for adding StackOverflow", profile.stack_overflow_profile)
    rep_points = profile.stack_overflow_profile.reputation / 100
    profile.earn(rep_points, :knowledge_points, "for StackOverflow reputation", profile.stack_overflow_profile)
  end
  
  def self.calculate_score_for_speaker_rate(profile)
    return unless profile.speaker_rate_profile
    profile.earn(10, :speaker_points, "for adding SpeakerRate", profile.speaker_rate_profile) 
  end
  
  def self.calculate_score_for_slide_share(profile)
    return unless profile.slide_share_profile
    profile.earn(10, :speaker_points, "for adding SlideShare", profile.slide_share_profile) 
  end
  
  def self.calculate_score_for_talks(profile)
    profile.talks.each do |talk|
      profile.earn(10, :speaker_points, "for Talk", talk) 
    end
  end
  
  def self.calculate_score_for_blogs(profile)
    profile.blogs.each do |blog|
      profile.earn(10, :writer_points, "for adding a blog", blog) 
      blog.posts.each do |post|
        profile.earn(3, :writer_points, "for adding a post", post) 
      end
    end    
  end
  
  def self.calculate_score_for_twitter(profile)
    return unless profile.twitter_profile
    profile.earn(10, :social_points, "for adding Twitter", profile.twitter_profile) 
  end
end