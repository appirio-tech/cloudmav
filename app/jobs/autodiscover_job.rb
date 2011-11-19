class AutodiscoverJob
  @queue = :autodiscover
  
  def self.perform(id)
    profile = Profile.find(id)
        
    if profile.git_hub_profile.nil?
      Resque.enqueue(AutodiscoverGitHubProfileJob, id) 
    else
      profile.add_autodiscover_history_for("GitHub")
    end
    
    if profile.bitbucket_profile.nil?
      Resque.enqueue(AutodiscoverBitbucketProfileJob, id)
    else
      profile.add_autodiscover_history_for("Bitbucket")
    end
  end
  
end