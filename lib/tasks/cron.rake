desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

 if Time.now.hour >= 0 || Time.new.hour <= 1 
   Profile.synch_all!
 end
 
end
