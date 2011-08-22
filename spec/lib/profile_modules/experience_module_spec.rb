#require 'spec_helper'
#
#describe "ExperienceModule" do
#  
#  describe "calculate_experience" do
#    before(:each) do
#      @profile = Factory.create(:profile)
#      @previous_experience = Factory.build(:experience)
#      @profile.experiences << @previous_experience
#      
#      @project = Factory.build(:project)
#      @ruby = Factory.create(:technology, :name => "Ruby")
#      @project.technologies << @ruby
#      @profile.projects << @project
#      @profile.save
#      
#      @profile.calculate_experience
#      @profile.save
#    end
#    
#    it { @profile.experiences.with("Ruby").first.should_not be_nil }
#  end
#  
#end
