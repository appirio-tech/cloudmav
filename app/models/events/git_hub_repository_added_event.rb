class GitHubRepositoryAddedEvent < ProfileEvent

  referenced_in :git_hub_repository, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Code"
    self.subcategory = "GitHub"
  end

end
