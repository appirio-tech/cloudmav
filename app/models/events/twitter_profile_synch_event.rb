class TwitterProfileSynchEvent < SynchEvent

  referenced_in :twitter_profile, :inverse_of => :events

  def synch
    return if twitter_profile.username.nil?

    twitter_info = Twitter.user(twitter_profile.username)
    profile.name = twitter_info.name unless profile.name
    profile.location = twitter_info.location unless profile.location

    twitter_profile.followers_count = twitter_info.followers_count

    twitter_profile.profile.save!
    twitter_profile.save!
  end

end

