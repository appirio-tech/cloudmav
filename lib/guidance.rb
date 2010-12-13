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