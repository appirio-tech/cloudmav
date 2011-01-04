class SlideShareProfile
  include Mongoid::Document
  
  field :slide_share_username
  
  embedded_in :profile, :inverse_of => :slide_share_profile
  
  def sync!
    ss_talks = SlideShare.find_talks_for(slide_share_username)
    ss_talks.each do |ss_talk|
      
    end
    self.profile.save!
    self.save!
  end
  
  def as_json(opts={})
    { 
      :slide_share_username => slide_share_username
    }
  end
  
end