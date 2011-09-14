class AutodiscoverBitbucketProfileJob
  
  def self.perform(id)
    profile = Profile.find(id)
    profile.autodiscover_histories.create(:name => "Bitbucket")
    
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