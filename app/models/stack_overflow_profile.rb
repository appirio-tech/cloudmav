class StackOverflowProfile
  include Mongoid::Document
  
  field :stack_overflow_id
  field :reputation, :type => Integer, :default => 0
  field :url, :type => String
  field :badge_html
  
  embedded_in :profile, :inverse_of => :stack_overflow_profile
  
  def synch!
    return if stack_overflow_id.nil?
    
    flair = StackOverflow.get_flair(self.stack_overflow_id)
    self.url = flair["profileUrl"]
    self.reputation = flair["reputation"]
    self.badge_html = flair["badgeHtml"]
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