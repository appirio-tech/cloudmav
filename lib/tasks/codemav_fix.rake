namespace :codemav do
  
  desc "Fix followings"
  task :fix_followings => :environment do
    Following.all.each do |f|
      if f.respond_to?(:profile_id)
        p = Profile.find(f.profile_id)
        f.followable = p
        f.save
      end
    end
  end

end
