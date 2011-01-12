class SlideShareProfile
  include Mongoid::Document
  
  field :slide_share_username
  field :url
  
  embedded_in :profile, :inverse_of => :slide_share_profile
  
  before_save :set_url
  
  def synch!
    response = SlideShare.get_slideshows_by_user(slide_share_username)
    response["User"]["Slideshow"].each do |ss_talk|
      self.profile.talks << create_talk(ss_talk) unless has_talk?(ss_talk)
    end
    self.profile.save!
    self.save!
  end
  
  def as_json(opts={})
    { 
      :slide_share_username => slide_share_username
    }
  end
  
  private
    def set_url
      self.url = "http://www.speakerrate.net/#{self.slide_share_username}"
    end
    
    def has_talk?(ss_talk)
      !self.profile.talks.where(:imported_id => ss_talk["ID"]).first.nil?
    end
    
    def create_talk(ss_talk)
      talk = Talk.new
      talk.title = ss_talk["Title"]
      talk.description = ss_talk["Description"]
      talk.slides_url = ss_talk["DownloadUrl"]
      talk.slides_thumbnail = ss_talk["ThumbnailURL"]
      talk.imported_id = ss_talk["ID"]
      return talk
    end
end