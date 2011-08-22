class CoderWallProfileSyncEvent < SyncEvent
  referenced_in :coder_wall_profile, :inverse_of => :events

  def earn_points
    points = coder_wall_profile.badges_count * 5
    coder_wall_profile.profile.adjust_score("CoderWall badges", points, :coder_points)
  end

  def sync
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
    coder_wall_profile.profile.save
  end

  def award_badges
  end

end

