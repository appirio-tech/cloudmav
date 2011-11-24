class DevJourneyPresenter
  
  def self.as_javascript(data)
    items = []
    data.each do |d|
      # puts ""
      # puts d.inspect
      data = d[:data].map{|i| %Q{ { date: Date.parse('#{i[:date]}'), score: #{i[:score]} } }}.join(", ")
      items << %Q{ { name: '#{d[:name]}', data: [#{data}]} }      
    end
    
    %Q{[#{items.join(", ")}]}.html_safe
  end
  
  def self.get_javascript_data(profile)
    as_javascript(get_data(profile))
  end
  
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
      result = aggregate_by_month(consolidated_data)
      result = convert_dates(result)

      skill_data[:data] = result      
      data << skill_data
    end
    data
  end
  
  def self.convert_dates(data)
    data.each { |d| d[:date] = d[:date].strftime("%m/%d/%Y") }
  end
  
  def self.aggregate_by_month(data)
    sum = 0
    result = []
    last_date = nil
    data.each do |d|
      date = d[:date]
      score = d[:score]
      unless last_date.nil? || (date.month == (last_date >> 1).month)
        months_in_date_range(last_date >> 1, date << 1).each do |d|
          result << {
            :date => d,
            :score => sum
          }
        end        
      end
      sum = sum + score
      last_date = date
      result << {
        :date => date,
        :score => sum
      }      
    end
    result
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
  end
  
  def self.add_skill_data_for_job(skilling, skillings_by_month)
    job = skilling.subject
    months = months_in_date_range(job.start_date, job.end_date)
    
    skill_pts_per_month = (skilling.score / months.count)
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