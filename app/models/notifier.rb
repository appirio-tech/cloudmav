class Notifier < ActionMailer::Base
  default :from => "CodeMav noreply@codemav.com",
          :return_path => "noreply@codemav.com",
          "reply-to" => "noreply@codemav.com", 
          "X-No-Spam" => "True"
  
  def contact(contact)
    @contact = contact
    mail(:to => "contact@codemav.com",
         :subject => "Contact : #{@contact.subject}")
  end

end
