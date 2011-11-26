namespace :codemav do
  
  desc "Setup skills"
  task :setup_skills => :environment do
    Skill.create_or_update!("ruby", ["ruby", "rails", "Ruby"])
    Skill.create_or_update!("csharp", ["csharp", "C#", "c#"])
  end

end
