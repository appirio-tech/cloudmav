class GitHubRepositoryAddedEvent < ProfileEvent

  referenced_in :git_hub_repository, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Code"
    self.subcategory = "GitHub"
    self.date = git_hub_repository.creation_date
  end

  def description
    %Q{created #{git_hub_repository.name} repository}
  end

end
