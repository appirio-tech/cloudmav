class Presentation
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  
  field :presentation_date, :type => DateTime
  field :audience, :type => String
  field :url, :type => String
  
  referenced_in :talk, :inverse_of => :presentations

  def profile
    talk.profile
  end

  def self.send_reminders!
    future_presentations = Presentation.where(:presentation_date => 1.week.from_now)
    future_presentations.each do |p|
      Notifier.delay.presentation_reminder_for(p)
    end
  end
end
