class AdminEmailer < ActionMailer::Base
  default :from => "CodeMav admin@codemav.com",
          :return_path => "admin@codemav.com",
          "reply-to" => "admin@codemav.com", 
          "X-No-Spam" => "True"
  
  def daily_report
    @total_users_count = User.count
    @new_users = User.users_created_today
    @daily_events = Event.events_created_today

    mail(:to => "rookieone@gmail.com",
          :subject => "Daily Email for #{DateTime.now.strftime("%m/%d/%y")}")
  end

end

