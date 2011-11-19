class UnsyncBitbucketProfileJob
  @queue = :sync
  
  def self.perform(id)
    bitbucket_profile = BitbucketProfile.find(id)        
    profile = bitbucket_profile.profile
    
    bitbucket_profile.repositories.destroy_all
    bitbucket_profile.destroy
    
    profile.remove_badge("Bucketeer")    
    profile.calculate_score!
  end

end