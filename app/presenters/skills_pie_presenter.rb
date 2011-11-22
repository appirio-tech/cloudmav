class SkillsPiePresenter

  def self.get_data(profile)
    data = []
    skill_scores = {}
    
    total = 0
    profile.skills.each do |skill|
      skill_scores[skill] = profile.skill_score(skill)
      total = total + skill_scores[skill]
    end
    
    profile.skills.each do |skill|
      data << {
        "skill" => skill,
        "score" => skill_scores[skill],
        "percent" => (skill_scores[skill].to_f / total.to_f) * 100
      }
    end
    
    data
  end
  
  def self.as_javascript(data)
    items = []
    data.each do |d|
      items << %Q{{"skill":"#{d["skill"]}", "score":#{d["score"]}, "percent":#{d["percent"]}}}      
    end
    
    %Q{[#{items.join(", ")}]}.html_safe
  end
  
  def self.get_javascript_data(profile)
    as_javascript(get_data(profile))
  end

end