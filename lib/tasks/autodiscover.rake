namespace :codemav do    
  desc "Autodiscover"
  task :autodiscover => :environment do
    page = StackOverflow.get_all_users
    new_profiles = Autodiscovery.process_stackoverflow_page(page)
    new_profiles.each do |p|
      Autodiscovery.process_profile(p)
    end
  end

end

