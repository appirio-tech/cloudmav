score 10, :coder_points, "for having a SO Account", :after => :save do      
  thing Profile
  subject :profile
  conditions do |p|
    !p.stack_overflow_profile.nil?
  end
end

score 10, :coder_points, "for having a GitHub Account", :after => :save do      
  thing Profile
  subject :profile
  conditions do |p|
    !p.git_hub_profile.nil?
  end
end

score 10, :writer_points, "for having a blog", :after => :save do      
  thing Profile
  subject :profile
  conditions do |p|
    p.has_badge_named?("iBlog")
  end
end

score 10, :speaker_points, "for having a SpeakerRate Account", :after => :save do
  thing Profile
  subject :profile
  conditions do |p|
    !p.speaker_rate_profile.nil?
  end
end