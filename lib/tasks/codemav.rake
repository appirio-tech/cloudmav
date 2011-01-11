namespace :codemav do    
  desc "Clear data"
  task :redo => :environment do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end