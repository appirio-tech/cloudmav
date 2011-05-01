class Presentation
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  
  field :presentation_date, :type => DateTime
  field :audience, :type => String
  field :url, :type => String
  field :video
  
  referenced_in :talk, :inverse_of => :presentations

  attr_accessor :video_url_input

  before_save :embed_video_link

  def profile
    talk.profile
  end

  def self.send_reminders!
    future_presentations = Presentation.where(:presentation_date => 1.week.from_now)
    future_presentations.each do |p|
      Notifier.delay.presentation_reminder_for(p)
    end
  end

  def video?
    !video.nil?
  end

  def embed_video_link 
    return if self.video_url_input.blank?
    embedly_api = Embedly::API.new 
    self.video = embedly_api.oembed :url => self.video_url_input
  end

end
