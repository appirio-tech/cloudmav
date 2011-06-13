class GitHubProfileResyncEvent < GitHubProfileSyncEvent

  def before_sync
    GitHubRepositoryAddedEvent.for_profile(profile).destroy_all
    git_hub_profile.repositories.destroy_all
    profile.recalculate_score!
  end

end



