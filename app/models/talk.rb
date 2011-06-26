class Talk
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Taggable
  include CodeMav::Indexable
  include CodeMav::Eventable
  
  field :title, :type => String
  field :description, :type => String
  field :slides_url, :type => String
  field :slides_thumbnail, :type => String
  field :imported_id, :type => String
  field :imported_from, :type => String
  field :willing_to_give_talk_again, :type => Boolean, :default => true
  field :presentation_date, :type => DateTime
  field :talk_creation_date, :type => DateTime
  field :audience, :type => String
  field :url, :type => String
  field :video_url, :type => String
  field :slideshow_html, :type => String 
  field :speaker_rating, :type => Float

  referenced_in :profile, :inverse_of => :talks
    
  validates_presence_of :title

  scope :for_profile, lambda { |profile| where(:profile_id => profile.id) }

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

  def self.send_reminders!
    future_talks = Talk.where(:presentation_date => 1.week.from_now)

    future_talks.each do |t|
      Notifier.delay.talk_reminder_for(t)
    end
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
  
end
