namespace :codemav do
  
  desc "Setup skills"
  task :setup_skills => :environment do
    Following.all.each do |f|
      if f.respond_to?(:profile_id)
        p = Profile.find(f.profile_id)
        f.followable = p
        f.save
      end
    end
  end

end
