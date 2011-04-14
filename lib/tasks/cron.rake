desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

 if Time.now.hour >= 0 || Time.now.hour <= 2 
   Profile.synch_all!
   Presentation.send_reminders!
 end
 
end
