class Notifier < ActionMailer::Base
  helper :application
  default :from => "CodeMav noreply@codemav.com",
          :return_path => "noreply@codemav.com",
          "reply-to" => "noreply@codemav.com", 
          "X-No-Spam" => "True"
  
  def contact(contact)
    @contact = contact
    mail(:to => "contact@codemav.com",
         :subject => "Contact : #{@contact.subject}")
  end

  def talk_reminder_for(talk)
    @profile = talk.profile
    @talk = talk
    mail(:to => talk.profile.email,
         :subject => "Talk Reminder")
  end

end
