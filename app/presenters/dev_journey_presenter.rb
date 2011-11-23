class DevJourneyPresenter
  
  def self.get_data(profile)
    data = []
    profile.skills.each do |skill|
      skill_data = { :name => skill }
      skillings_by_month = []
      profile.skillings.where(:skill_name => skill).each do |skilling|
        
        if skilling_for_job?(skilling)
          add_skill_data_for_job(skilling, skillings_by_month)
        end
      end
      
      puts "skillings by months"
      puts skillings_by_month.inspect
      consolidated_data = skillings_by_month
      skill_data[:data] = consolidated_data
      data << skill_data
    end
    data
  end
  
  def self.skilling_for_job?(skilling)
    skilling.subject_class_name == "Job"
  end
  
  def self.add_skill_data_for_job(skilling, skillings_by_month)
    job = skilling.subject
    months = months_in_date_range(job.start_date, job.end_date)
    skill_pts_per_month = skilling.score / months.count
    months.each do |m|
      skillings_by_month << { :date => m.strftime("%m/%d/%Y"), :score => skill_pts_per_month }
    end
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