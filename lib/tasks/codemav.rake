namespace :codemav do    
  desc "Clear data"
  task :clear_data => :environment do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end