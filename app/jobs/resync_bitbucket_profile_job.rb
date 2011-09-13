class ResyncBitbucketProfileJob
  @queue = :sync
  
  def self.perform(id)
    bitbucket_profile = BitbucketProfile.find(id)
    bitbucket_profile.repositories.destroy_all
    bitbucket_profile.sync!
  end

end