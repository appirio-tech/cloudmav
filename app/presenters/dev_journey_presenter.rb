class DevJourneyPresenter
  
  def self.get_data(profile)
    data = []
    profile.skills.each do |skill|
      skill_data = { :name => skill }
      skillings_by_month = []
      profile.skillings.where(:skill_name => skill).each do |skilling|
        
        case skilling.subject_class_name
        when "Job"
          add_skill_data_for_job(skilling, skillings_by_month)
        when "GitHubRepository"
          add_skill_data_for_git_hub_repo(skilling, skillings_by_month)
        end
        
      end
      
      consolidated_data = consolidate_skillings_by_month(skillings_by_month)
      skill_data[:data] = consolidated_data
      data << skill_data
    end
    data
  end
  
  def self.consolidate_skillings_by_month(skillings_by_month)
    data = {}
    skillings_by_month.each do |s|
      score = data[s[:date]] || 0
      data[s[:date]] = score + s[:score]
    end
    result = []
    data.each do |k,v|
      result << { :date => DateTime.parse(k), :score => v }
    end
    sorted = result.sort { |a,b| a[:date] <=> b[:date] }
    sorted.each { |d| d[:date] = d[:date].strftime("%m/%d/%Y") }
  end
  
  def self.add_skill_data_for_job(skilling, skillings_by_month)
    job = skilling.subject
    months = months_in_date_range(job.start_date, job.end_date)
    skill_pts_per_month = skilling.score / months.count
    months.each do |m|
      skillings_by_month << { :date => m.strftime("%d/%m/%Y"), :score => skill_pts_per_month }
    end
  end
  
  def self.add_skill_data_for_git_hub_repo(skilling, skillings_by_month)
    repo = skilling.subject
    cd = DateTime.parse(repo.creation_date)
    date = Date.new cd.year, cd.month
    skillings_by_month << { :date => date.strftime("%d/%m/%Y"), :score => skilling.score }
  end
  
  def self.months_in_date_range(from, to)
    from, to = to, from if from > to
    m = Date.new from.year, from.month
    result = []
    while m <= to
      result << m
      m >>= 1
    end

    result
  end
  
end