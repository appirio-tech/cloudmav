require 'spec_helper'

describe ExperienceModule do
  
  
  # def calculate_experience
  #     self.experiences.each{|e| e.destroy}
  #     self.projects.each do |project|
  #       project_xp = project.get_xp
  #       project_xp.keys.each_pair do |name, duration|
  #         xp = find_create_xp(name)
  #         xp.duration += duration
  #       end
  #     end
  #   end
  #   
  
  describe "calculate_experience" do
    before(:each) do
      @profile = Factory.create(:profile)
      @previous_experience = Factory.build(:experience)
      @profile.experiences << @previous_experience
      
      @project = Factory.build(:project)
      @ruby = Factory.build(:technology, :name => "Ruby")
      @project.technologies << @ruby
      @profile.projects << @project
      @profile.save
      
      @profile.calculate_experience
      @profile.save
    end
    
    it { Experience.exists?(@previous_experience).should == false }
    it { @profile.experiences.with("Ruby").first.should_not be_nil }
  end
  
end