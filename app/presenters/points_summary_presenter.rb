class PointsSummaryPresenter
  
  def self.get_list(profile)    
    list = []
    
    add_scorings_for("experience_points", profile, list, "Experience", "experience")
    add_scorings_for("knowledge_points", profile, list, "Knowledge", "knowledge")
    add_scorings_for("coder_points", profile, list, "Code", "code")
    add_scorings_for("writer_points", profile, list, "Writing", "writing")
    add_scorings_for("speaker_points", profile, list, "Speaking", "speaking")
    add_scorings_for("social_points", profile, list, "Social", "social")    
    list
  end
  
  def self.add_scorings_for(point_type, profile, list, title, anchor)
    scorings = profile.scorings.select{|s| s.point_type == point_type }

    list << {
      :title => title,
      :point_type => point_type,
      :scorings => scorings,
      :anchor => anchor
    }
  end  
  
end