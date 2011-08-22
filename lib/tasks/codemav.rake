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
      begin
        e.set_base_info
        e.save
      rescue => details
        puts "Error #{details}"
      end
    end
  end

  desc "Recalculate points"
  task :recalc_points => :environment do
    Profile.all.to_a.each do |p|
      p.recalculate_score!
    end
  end

  desc "Test"
  task :test => :environment do
    puts "Test to see if rake is working"
  end
end
