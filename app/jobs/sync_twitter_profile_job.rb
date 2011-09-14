class SyncTwitterProfileJob
  @queue = :sync
  
  def self.perform(id)
    twitter_profile = TwitterProfile.find(id)
    profile = twitter_profile.profile
    
    return if twitter_profile.username.nil?

    twitter_info = Twitter.user(twitter_profile.username)
    profile.name = twitter_info.name unless profile.name
    profile.location = twitter_info.location unless profile.location

    twitter_profile.followers_count = twitter_info.followers_count
    twitter_profile.url = "http://www.twitter.com/#{twitter_profile.username}"

    profile.save!
    twitter_profile.save!
    
    profile.calculate_score!  
  end

end