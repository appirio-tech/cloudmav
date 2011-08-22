class BitbucketProfileUnsyncEvent < UnsyncEvent
  referenced_in :bitbucket_profile, :inverse_of => :events

  def other_work
    BitbucketProfileAddedEvent.for_profile(profile).destroy_all
    BitbucketProfileSyncEvent.for_profile(profile).destroy_all
    BitbucketRepositoryAddedEvent.for_profile(profile).destroy_all
    bitbucket_profile.repositories.destroy_all
  end

  def remove_badges
    remove_badge("Bucketeer")
  end

end


