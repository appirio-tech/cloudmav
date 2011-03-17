class StackOverflowProfileSynchEvent < SynchEvent

  referenced_in :stack_overflow_profile, :inverse_of => :events

  def synch
    return if stack_overflow_profile.stack_overflow_id.nil?
    
    user = StackOverflow.get_user(stack_overflow_profile.stack_overflow_id)
    stack_overflow_profile.profile.name = user["display_name"] if stack_overflow_profile.profile.name.nil?
    stack_overflow_profile.url = "http://www.stackoverflow.com/users/#{stack_overflow_profile.stack_overflow_id}"
    stack_overflow_profile.reputation = user["reputation"]
    stack_overflow_profile.badge_html = user["badgeHtml"]
    tags = StackOverflow.get_user_tags(stack_overflow_profile.stack_overflow_id)
    so_tags = {}
    tags["tags"].each do |t|
      so_tags[t["name"]] = t["count"]
    end
    stack_overflow_profile.stack_overflow_tags = so_tags.to_yaml
    stack_overflow_profile.profile.save!
    stack_overflow_profile.save!

    stack_overflow_profile.retag!
  end

  def award_badges
    if stack_overflow_profile.reputation > 10000
      profile.award_badge("I'm kind of a Big Deal", :description => "For having a StackOverflow reputation over 10k")
    end
  end

end
