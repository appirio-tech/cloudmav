namespace :codemav do    
  desc "Clear data"
  task :clear_data => :environment do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end

  desc "Tag profiles"
  task :tag_profiles => :environment do
    Profile.all.each do |profile|
      profile.calculate_tags
      profile.save
    end
  end

  desc "Tag talks"
  task :tag_talks => :environment do
    Talk.all.each do |talk|
      talk.calculate_tags
      talk.save
    end
  end
end
