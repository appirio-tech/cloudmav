namespace :codemav do    
  desc "Autodiscover"
  task :autodiscover => :environment do
    1.times do |i|
      page = StackOverflow.get_all_users(:page => i, :per_page => 100)
      new_profiles = Autodiscovery.process_stackoverflow_page(page)
      new_profiles.each do |p|
        Autodiscovery.process_profile(p)
      end
    end
  end

end

