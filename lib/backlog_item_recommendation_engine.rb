class BacklogItemRecommendationEngine

  def self.build_recommendations!
    Profile.all.each { |p| build_recommendations_for_profile!(p) }
  end

  def self.build_recommendations_for_profile!(profile)
    BacklogItem.all.each do |item|
      rec = get_backlog_item_recommendation(profile, item)
      rec.score = 0
      rec.score += get_score_for_tags(item, profile)
      rec.score += get_score_for_dates(item, profile)
    end
    add_score_for_proximity(profile) if profile.has_location?
    profile.save
  end

  def self.get_backlog_item_recommendation(profile, item)
    rec = profile.backlog_item_recommendations.where(:backlog_item_id => item.id).first
    unless rec
      rec = BacklogItemRecommendation.new(:backlog_item_id => item.id)
      profile.backlog_item_recommendations << rec
    end
    rec
  end

  def self.get_score_for_tags(backlog_item, profile)
    score = 0
    profile.taggings.each do |t|
      if backlog_item.has_tag?(t.tag)
        score += t.score * 10
      end
    end
    score
  end

  def self.get_score_for_dates(backlog_item, profile)
    score = 0
    if backlog_item.start_date
      start_date = backlog_item.start_date
      score += 30 if start_date <= 1.week.from_now
      score += 20 if start_date <= 2.weeks.from_now
      score += 10 if start_date <= 1.month.from_now
    end
    score
  end

  def self.add_score_for_proximity(profile)
    BacklogItem.with_location.near_locatable(profile, :distance => 50).each do |item|
      rec = get_backlog_item_recommendation(profile, item)
      rec.score += 10
    end
    BacklogItem.with_location.near_locatable(profile, :distance => 200).each do |item|
      rec = get_backlog_item_recommendation(profile, item)
      rec.score += 10
    end
    BacklogItem.with_location.near_locatable(profile, :distance => 500).each do |item|
      rec = get_backlog_item_recommendation(profile, item)
      rec.score += 10
    end
  end

end
