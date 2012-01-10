class ProfileActivityPresenter
  
  def self.get_activity(profile)
    activity = []
    
    activity << get_activity_for_github(profile.git_hub_profile)
    
    activity.flatten
  end
  
  def self.get_activity_for_github(git_hub_profile)
    return [] if git_hub_profile.nil?
    
    activity_atom_url = "https://github.com/#{git_hub_profile.username}.atom"
    rss = SimpleRSS.parse open(activity_atom_url)
  
    activity = []
    rss.entries.each do |e|
      activity << {
        :title => e.title,
        :url => e.link,
        :html => e.content,
        :date => e.published
      }
    end

    activity
  end
  
end