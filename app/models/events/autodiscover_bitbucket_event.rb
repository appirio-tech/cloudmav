class AutodiscoverBitbucketEvent < AutodiscoverEvent

  def set_info
    self.discover_type = "Bitbucket"
  end

  def discover
    if profile.username
      user_info = BitbucketApi.get_user(profile.username)
      if user_info
        profile.bitbucket_profile = BitbucketProfile.new(:username => profile.username)
        profile.bitbucket_profile.save
        profile.save
        profile.bitbucket_profile.sync!
      end
    end
  end

end

