namespace :codemav do    
  desc "Autodiscover"
  task :autodiscover => :environment do
    page = StackOverflow.get_all_users
    Autodiscovery.process_stackoverflow_page(page)
  end

end

