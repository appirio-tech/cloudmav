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

end