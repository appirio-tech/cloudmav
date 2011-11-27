class DevJourneyJobsPresenter
  
  def self.get_data(profile)
    data = []
    
    profile.jobs.each do |j|
      sd = j.start_date
      ed = j.end_date || DateTime.now
      data << {
        :company_name => j.company_name,
        :job_title => j.title,
        :start_date => sd.strftime("%m/%d/%Y"),
        :end_date => ed.strftime("%m/%d/%Y")
      }      
    end
    
    return {
      :data => data,
      :javascript_data => as_javascript(data)
    }
  end
  
  def self.as_javascript(data)
    items = data.map{|i| %Q{ { CompanyName: '#{i[:company_name]}', JobTitle: '#{i[:job_title]}', StartDate: Date.parse('#{i[:start_date]}'), EndDate: Date.parse('#{i[:end_date]}') } }}
    
    %Q{[#{items.join(", ")}]}.html_safe
  end
  
end