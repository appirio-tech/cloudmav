class GitHubProfileUnsyncEvent < UnsyncEvent
  referenced_in :git_hub_profile, :inverse_of => :events

  def other_work
    GitHubProfileAddedEvent.for_profile(profile).destroy_all
    GitHubProfileSyncEvent.for_profile(profile).destroy_all
    GitHubRepositoryAddedEvent.for_profile(profile).destroy_all
    git_hub_profile.repositories.destroy_all
  end

  def remove_badges
    remove_badge("Git R Done")
  end

end



