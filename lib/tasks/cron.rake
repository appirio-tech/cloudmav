desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

 if Time.now.hour == 0 
   Profile.sync_all!
   Presentation.send_reminders!
 end

 if Time.now.hour == 23
   AdminEmailer.daily_report.deliver
 end
 
end
