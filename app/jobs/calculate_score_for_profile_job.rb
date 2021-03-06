class CalculateScoreForProfileJob
  @queue = :scoring
  
  def self.perform(profile_id)
    profile = Profile.find(profile_id)
    profile.clear_score!
    
    # knowledge
    calculate_score_for_stack_overflow(profile)
    
    # experience
    calculate_score_for_experience(profile)
    
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
    profile.calculate_skills!
  end
  
  def self.calculate_score_for_git_hub(profile)
    return unless profile.git_hub_profile
    profile.earn(10, :coder_points, "For adding GitHub", profile.git_hub_profile)

    repos = profile.git_hub_profile.repositories
    return if repos.nil?
    
    repos.each do |r|
      r.clear_score!
      points = 1
      points = points + (r.watchers || 0) * 0.1
      points = points + (r.forks || 0) * 0.15
      points = points.round
      r.earn(points, :coder_points, "For repository '#{r.name}'", r)
      profile.earn(points, :coder_points, "For repository '#{r.name}'", r)
    end
  end
  
  def self.calculate_score_for_bitbucket(profile)
    return unless profile.bitbucket_profile
    profile.earn(10, :coder_points, "For adding Bitbucket", profile.bitbucket_profile)    
  end
  
  def self.calculate_score_for_coder_wall(profile)
    return unless profile.coder_wall_profile
    points = profile.coder_wall_profile.badges_count * 5
    profile.earn(10, :coder_points, "For adding CoderWall", profile.coder_wall_profile)
    profile.earn(points, :coder_points, "For CoderWall badges", profile.coder_wall_profile)    
  end
  
  def self.calculate_score_for_stack_overflow(profile)
    return unless profile.stack_overflow_profile
    profile.earn(10, :knowledge_points, "For adding StackOverflow", profile.stack_overflow_profile)
    rep_points = profile.stack_overflow_profile.reputation / 100
    profile.earn(rep_points, :knowledge_points, "For StackOverflow reputation of #{profile.stack_overflow_profile.reputation}", profile.stack_overflow_profile)
  end
  
  def self.calculate_score_for_speaker_rate(profile)
    return unless profile.speaker_rate_profile
    profile.earn(10, :speaker_points, "For adding SpeakerRate", profile.speaker_rate_profile) 
  end
  
  def self.calculate_score_for_slide_share(profile)
    return unless profile.slide_share_profile
    profile.earn(10, :speaker_points, "For adding SlideShare", profile.slide_share_profile) 
  end
  
  def self.calculate_score_for_talks(profile)
    profile.talks.each do |talk|
      talk.clear_score!
      talk.earn(10, :speaker_points, "For talk '#{talk.title}'", talk)
      profile.earn(talk.total_score, :speaker_points, "For talk '#{talk.title}'", talk) 
    end
  end
  
  def self.calculate_score_for_blogs(profile)
    profile.blogs.each do |blog|
      profile.earn(10, :writer_points, "For adding a blog '#{blog.title}'", blog) 
      blog.posts.each do |post|
        profile.earn(3, :writer_points, "For adding a post '#{post.title}'", post) 
      end
    end    
  end
  
  def self.calculate_score_for_twitter(profile)
    return unless profile.twitter_profile
    profile.earn(10, :social_points, "For adding Twitter", profile.twitter_profile) 
  end
  
  def self.calculate_score_for_experience(profile)
    return unless profile.jobs
    profile.jobs.each do |job|
      job.clear_score!
      duration = job.job_duration_in_days
      points = (duration * 0.05).round
      job.earn(points, :experience_points, "For #{job.title} job at #{job.company_name}", job)
      profile.earn(points, :experience_points, "For #{job.title} job at #{job.company_name}", job)
    end
  end
  
end