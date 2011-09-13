class SyncCoderWallProfileJob
  @queue = :sync
  
  def self.perform(id)
    coder_wall_profile = CoderWallProfile.find(id)
    profile = coder_wall_profile.profile
    return if coder_wall_profile.username.nil?

    url = URI.parse("http://www.coderwall.com/#{coder_wall_profile.username}.json")
    response = Net::HTTP.get_response url

    return if response.body.blank?
    result = JSON.parse(response.body)

    coder_wall_profile.url = "http://www.coderwall.com/#{coder_wall_profile.username}"
    coder_wall_profile.badges_count = result["badges"].count

    result["badges"].each do |b|
      badge = coder_wall_profile.badges.where(:name => b["name"]).first
      if badge.nil?
        badge = CoderWallBadge.new(:name => b["name"], :badge => b["badge"], :description => b["description"])
        coder_wall_profile.badges << badge
        badge.save
      end
    end

    coder_wall_profile.save

    profile.calculate_score!   
  end

end