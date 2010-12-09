score 10, :coder_points, "for having a SO Account", :after => :save do      
  thing Profile
  subject :profile
  conditions do |p|
    !p.stack_overflow_profile.nil?
  end
end

score 50, :coder_points, "having earned 100 SO rep", :after => :save do
  thing Profile
  subject :profile
  conditions do |p|
    !p.stack_overflow_profile.nil? && p.stack_overflow_profile.reputation >= 100
  end 
end

score 10, :coder_points, "for having a GitHub Account", :after => :save do      
  thing Profile
  subject :profile
  conditions do |p|
    !p.git_hub_profile.nil?
  end
end