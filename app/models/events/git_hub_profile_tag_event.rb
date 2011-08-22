class GitHubProfileTagEvent < TagEvent

  def set_tags
    @git_hub_profile = taggable

    @git_hub_profile.repositories.each do |r|
      unless r.language.blank?
        tag r.language.downcase, :score => 10
      end
    end
  end

end

