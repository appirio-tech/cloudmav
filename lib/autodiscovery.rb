class Autodiscovery

  def self.process_stackoverflow_page(page)
    new_profiles = []
    page["users"].each do |so_user|
      sp = StackOverflowProfile.where(:stack_overflow_id => so_user["user_id"]).first
      if sp.nil?
        p = Profile.new(:name => so_user["display_name"], 
                        :username => "auto_#{so_user["user_id"]}",
                        :gravatar_id => so_user["email_hash"])
        p.stack_overflow_profile = StackOverflowProfile.new(:stack_overflow_id => so_user["user_id"])
        p.stack_overflow_profile.save
        p.save
        new_profiles << p
      end
    end
    new_profiles
  end

  def self.discover_github(profile)
    url = URI.parse("http://github.com/api/v2/json/user/search/#{profile.name.split.last}")
    response = Net::HTTP.get_response url
    result = JSON.parse(response.body)
    match = nil
    result["users"].each do |github_user|
      unless match
        match = github_user
      end
    end

    if match
      profile.username = match["username"]
      profile.git_hub_profile = GitHubProfile.new(:username => match["username"])
      profile.git_hub_profile.save
      profile.save
    end
  end

  def self.discover_bitbucket(profile)
    if profile.username
      user_info = BitbucketApi.get_user(profile.username)
      if user_info
        profile.bitbucket_profile = BitbucketProfile.new(:username => profile.username)
        profile.bitbucket_profile.save
        profile.save
      end
    end
  end

end
