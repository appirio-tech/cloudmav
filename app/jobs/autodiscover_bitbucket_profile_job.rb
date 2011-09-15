class AutodiscoverBitbucketProfileJob
  @queue = :autodiscover
  
  def self.perform(id)
    profile = Profile.find(id)
    profile.add_autodiscover_history_for("Bitbucket")
    
    begin
      if profile.username
        user_info = BitbucketApi.get_user(profile.username)
        if user_info
          profile.bitbucket_profile = BitbucketProfile.new(:username => profile.username)
          profile.bitbucket_profile.save
          profile.save
          profile.bitbucket_profile.sync!
        end
      end
    rescue
    end    
  end
  
end