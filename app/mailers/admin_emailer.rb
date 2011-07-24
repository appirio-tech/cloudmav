class AdminEmailer < ActionMailer::Base
  default :from => "CodeMav admin@codemav.com",
          :return_path => "admin@codemav.com",
          "reply-to" => "admin@codemav.com", 
          "X-No-Spam" => "True"
  
  def daily_report
    @total_users_count = User.count
    @new_users = User.users_created_today
    @total_daily_events_count = Event.events_created_today.count

    mail(:to => "rookieone@gmail.com",
          :subject => "Daily Email for #{DateTime.now}")
  end

end

