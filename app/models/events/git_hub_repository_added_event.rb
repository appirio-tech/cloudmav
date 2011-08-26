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

  def icon_url
    "event_icons/github.png"
  end

  def score_points
    points = 1
    points = points + git_hub_repository.watchers * 0.1
    points = points + git_hub_repository.forks * 0.15
    points = points.round
    profile.earn("for repository value", points, :coder_points) 
  end

end
