learn "Synching with your Stackoverflow Account" do      
  thing Profile
  subject :profile
  partial :synch_stack_overflow
  conditions do |p|
    !p.stack_overflow_profile.nil?
  end
end