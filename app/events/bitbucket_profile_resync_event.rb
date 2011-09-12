class BitbucketProfileResyncEvent < BitbucketProfileSyncEvent

  def before_sync
    BitbucketRepositoryAddedEvent.for_profile(profile).destroy_all
    bitbucket_profile.repositories.destroy_all
    profile.recalculate_score!
  end

end


