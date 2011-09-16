class Talk
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Indexable
  include CodeMav::Scorable
  
  field :title, :type => String
  field :permalink, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  field :imported_id, :type => String
  field :imported_from, :type => String
  field :willing_to_give_talk_again, :type => Boolean, :default => true
  field :presentation_date, :type => DateTime
  field :talk_creation_date, :type => DateTime
  field :audience, :type => String
  field :url, :type => String
  field :video_url, :type => String

  field :has_slide_share, :type => Boolean, :default => false
  field :slide_share_id, :type => String
  field :slideshow_html, :type => String 
  field :slide_share_thumbnail, :type => String
  field :slide_share_download_url, :type => String

  field :has_speaker_rate, :type => Boolean, :default => false
  field :speaker_rate_id, :type => String
  field :speaker_rating, :type => Float
  field :speaker_rate_url, :type => String
  field :speaker_rate_slides_url, :type => String

  belongs_to :profile
    
  validates_presence_of :title

  scope :for_profile, lambda { |profile| where(:profile_id => profile.id) }
  scope :by_permalink, lambda { |permalink| where(:permalink => permalink) }
  scope :from_speaker_rate, lambda { where(:has_speaker_rate => true) }
  scope :from_slide_share, lambda { where(:has_slide_share => true) }

  before_create :create_permalink_from_title

  def self.search(query, options = {})
    search = Sunspot.new_search(Talk)
    search.build do
      keywords query do
      end
    end
    search.execute
  end

  def related_items
    [profile.speaker_profile]
  end
  
  def generate_tags
  end

  def self.send_reminders!
    future_talks = Talk.where(:presentation_date => 1.week.from_now)

    future_talks.each do |t|
      Notifier.delay.talk_reminder_for(t)
    end
  end

  def on_speaker_rate?
    self.has_speaker_rate
  end

  def on_slide_share?
    self.has_slide_share
  end

  def preview_pic
    return self.slide_share_thumbnail if self.has_slide_share
    "default_talk.png"
  end
  
  def slides?
    !slides_url.nil?
  end

  def video?
    !video_url.nil?
  end

  def date_string
    return if presentation_date.nil?
    self.presentation_date.strftime('%m/%d/%Y')
  end

  def time_string
    return if presentation_date.nil?
    self.presentation_date.strftime('%I:%M%p')
  end

  def to_param
    self.permalink
  end
  
  def create_permalink_from_title
    if permalink.nil?
      self.permalink = FriendlyUrl.normalize(self.title)
    end
  end

  def clear_speaker_rate_info!
    self.has_speaker_rate = false
    self.speaker_rate_id = nil
    self.speaker_rating = nil
    self.speaker_rate_url = nil
    self.speaker_rate_slides_url = nil
    self.save
  end

  def copy_speaker_rate_info_from(talk)
    self.has_speaker_rate = true
    self.speaker_rate_id = talk.speaker_rate_id
    self.speaker_rating = talk.speaker_rating
    self.speaker_rate_url = talk.speaker_rate_url
    self.speaker_rate_slides_url = talk.speaker_rate_slides_url
  end

  def clear_slide_share_info!
    self.has_slide_share = false
    self.slide_share_id = nil
    self.slideshow_html = nil
    self.slide_share_thumbnail = nil
    self.slide_share_download_url = nil
    self.save
  end

  def copy_slide_share_info_from(talk)
    self.has_slide_share = true
    self.slide_share_id = talk.slide_share_id
    self.slideshow_html = talk.slideshow_html
    self.slide_share_thumbnail = talk.slide_share_thumbnail
    self.slide_share_download_url = talk.slide_share_download_url
  end

end
