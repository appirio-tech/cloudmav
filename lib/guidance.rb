learn "Synching with your Stackoverflow Account" do      
  thing Profile
  subject :profile
  partial :synch_stack_overflow
  conditions do |p|
    !p.stack_overflow_profile.nil?
  end
end

learn "Synching with your GitHub Account" do      
  thing Profile
  subject :profile
  partial :synch_git_hub
  conditions do |p|
    !p.git_hub_profile.nil?
  end
end

learn "To set my location" do
  thing Profile
  subject :profile
  partial :set_location
  conditions do |p|
    !p.location.nil?
  end
end

learn "Adding a blog to your profile" do
  thing Profile
  subject :profile
  partial :adding_a_blog
  conditions do |p|
    p.blogs.any?
  end
end

learn "Syncing with your SpeakerRate Account" do      
  thing Profile
  subject :profile
  partial :synch_speaker_rate
  conditions do |p|
    !p.speaker_rate_profile.nil?
  end
end

learn "Syncing with your SlideShare Account" do      
  thing Profile
  subject :profile
  partial :synch_slide_share
  conditions do |p|
    !p.slide_share_profile.nil?
  end
end

learn "Synching your Twitter Account" do      
  thing Profile
  subject :profile
  partial :synch_twitter
  conditions do |p|
    !p.twitter_profile.nil?
  end
end


