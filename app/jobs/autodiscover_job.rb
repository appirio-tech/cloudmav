class AutodiscoverJob
  
  def self.perform(id)
    profile = Profile.find(id)
        
    Resque.enqueue(AutodiscoverGitHubProfileJob, id) if profile.git_hub_profile.nil?
    Resque.enqueue(AutodiscoverBitbucketProfileJob, id) if profile.bitbucket_profile.nil?
  end
  
end