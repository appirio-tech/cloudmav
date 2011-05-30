class BitbucketRepositoryAddedEvent < ProfileEvent
  referenced_in :bitbucket_repository, :inverse_of => :events

  def set_info
    self.is_public = true
    self.category = "Code"
    self.subcategory = "Bitbucket"
  end

  def description
    %Q{created #{bitbucket_repository.name} repository}
  end

  def icon_url
    "event_icons/bitbucket.png"
  end

end

