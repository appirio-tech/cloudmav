class Autodiscovery

  def self.get_types_to_discover(profile)
    types = []
    types << "GitHub" if profile.git_hub_profile.nil?

    types
  end

  def self.get_event_class_for_type(type)
    event_name = "Autodiscover#{type}Event"
    Object.const_get(event_name)
  end

  def self.create_event(event_class, profile)
    event = event_class.new
    event.profile = profile
    event.save
  end

  def self.discover!(profile)
    types = get_types_to_discover(profile)
    types.each do |type|
      event_class = get_event_class_for_type(type)
      event = event_class.where(:profile_id => profile.id, :discover_type => type).first
      if event.nil?
        create_event(event_class, profile)
      end
    end
  end
   
  def self.process_profile(profile)
    profile = Profile.find(profile.id)
    discover_github(profile)
    discover_bitbucket(profile)
  end

  def self.process_stackoverflow_page(page)
    new_profiles = []
    page["users"].each do |so_user|
      sp = StackOverflowProfile.where(:stack_overflow_id => so_user["user_id"]).first
      if sp.nil?
        p = Profile.new(:name => so_user["display_name"], 
                        :username => "auto_#{so_user["user_id"]}",
                        :gravatar_id => so_user["email_hash"], 
                        :location => so_user["location"])
        p.stack_overflow_profile = StackOverflowProfile.new(:stack_overflow_id => so_user["user_id"])
        p.stack_overflow_profile.save
        p.save
        p.stack_overflow_profile.sync!
        new_profiles << p
      end
    end
    new_profiles
  end

  def self.discover_github(profile)
    begin
      name_to_search = profile.name.gsub('.','').split.last
      url = URI.parse("http://github.com/api/v2/json/user/search/#{name_to_search}")
    
      response = Net::HTTP.get_response url
      result = JSON.parse(response.body)
      match = nil
      
      result["users"].each do |github_user|
        unless match
          match = github_user if profile.gravatar_id == github_user["gravatar_id"]
        end
      end

      if match
        profile.location = match["location"] if profile.location.nil?
        profile.git_hub_profile = GitHubProfile.new(:username => match["username"])
        profile.git_hub_profile.save
        profile.save
        profile.git_hub_profile.sync!
      end
    rescue
    end
  end

  def self.discover_bitbucket(profile)
    begin
      if profile.username
        user_info = BitbucketApi.get_user(profile.username)
        if user_info
          profile.bitbucket_profile = BitbucketProfile.new(:username => profile.username)
          profile.bitbucket_profile.save
          profile.save
          profile.bitbucket_profile.sync!
        end
      end
    rescue
    end
  end

end
