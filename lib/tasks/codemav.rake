namespace :codemav do    
  desc "Clear data"
  task :clear_data => :environment do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    Sunspot.remove_all!(Profile, Talk, Company)
  end

  desc "Set event dates"
  task :set_event_dates => :environment do
    events = Event.all
    events.each do |e|
      e.date = e.created_at if e.date.nil?
      e.save
    end
  end

  desc "Set info on events"
  task :set_info_on_events => :environment do
    events = Event.all
    events.each do |e|
      e.set_base_info
      #e.set_info if e.respond_to? :set_info
      e.save
    end
  end
end
