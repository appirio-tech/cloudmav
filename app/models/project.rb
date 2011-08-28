class Project
  include Mongoid::Document
  
  field :name, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :technologies, :type => Array
  
  belongs_to :profile

  validate :start_before_end, :if => :start_and_end_date_not_nil
  
  def set_technologies!(technologies_string)
    self.technologies = []
    technology_names = technologies_string.split(',').map{|s| s.strip.camelize }

    technology_names.each do |name|
      technology = Technology.named(name).first
      unless technology
        technology = Technology.create(:name => name)
      end
      self.technologies << technology
    end
  end
  
  def get_xp
    return {} if self.start_date.nil? or self.end_date.nil?
    
    starts = Time.parse(self.start_date.to_s)
    ends = Time.parse(self.end_date.to_s) 
    duration = Duration.new(:seconds => ends - starts)
    xp = {}
    technologies.each{ |t| xp[t.name] = duration }
    return xp
  end
  
  protected
    def start_before_end
      if start_date > end_date
        errors.add("start_date", "must be before end date") 
        errors.add("end_date", "must be after start date")
      end
    end
    
    def start_and_end_date_not_nil
      !self.start_date.nil? && !self.end_date.nil?
    end
end
