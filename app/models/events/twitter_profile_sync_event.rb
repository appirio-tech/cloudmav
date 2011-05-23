class TwitterProfileSyncEvent < SyncEvent

  referenced_in :twitter_profile, :inverse_of => :events

  def sync
    return if twitter_profile.username.nil?

    twitter_info = Twitter.user(twitter_profile.username)
    profile.name = twitter_info.name unless profile.name
    profile.location = twitter_info.location unless profile.location

    twitter_profile.followers_count = twitter_info.followers_count
    twitter_profile.url = "http://www.twitter.com/#{twitter_profile.username}"

    twitter_profile.profile.save!
    twitter_profile.save!
  end

end

