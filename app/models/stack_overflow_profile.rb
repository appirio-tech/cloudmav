class StackOverflowProfile
  include Mongoid::Document
  include CodeMav::Taggable
  
  field :stack_overflow_id
  field :reputation, :type => Integer, :default => 0
  field :url, :type => String
  field :badge_html
  
  embedded_in :profile, :inverse_of => :stack_overflow_profile
  
  def synch!
    return if stack_overflow_id.nil?
    
    user = StackOverflow.get_user(self.stack_overflow_id)
    self.url = "http://www.stackoverflow.com/#{stack_overflow_id}"
    self.reputation = user["reputation"]
    self.badge_html = user["badgeHtml"]
    
    tags = StackOverflow.get_user_tags(self.stack_overflow_id)
    tags["tags"].each do |t|
      self.tag!(t["name"], :count => t["count"])
    end
    self.profile.save!
    self.save!
  end
  
  def as_json(opts={})
    { 
      :stack_overflow_id => stack_overflow_id,
      :reputation => reputation,
      :url => url,
      :badge_html => badge_html
    }
  end
end