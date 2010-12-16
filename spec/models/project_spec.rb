require 'spec_helper'

describe Project do
  before(:each) do
    @profile = Factory.create(:profile)
    @project = Project.new
    @profile.projects << @project
  end
  
  describe "set technologies" do
    context "new technology" do
      before(:each) do
        @project.set_technologies!("ruby")
        @profile.save
      end

      it { @project.technologies.first.name.should == "Ruby" }
      it { Technology.named("Ruby").first.should_not be_nil }      
    end
    
    context "existing technology" do
      before(:each) do
        Technology.create(:name => "Ruby")
        @project.set_technologies!("ruby")
        @profile.save
      end

      it { @project.technologies.first.name.should == "Ruby" }
      it { Technology.named("Ruby").count.should == 1 }      
    end
    
    context "2 technologies" do
      before(:each) do
        @project.set_technologies!("ruby, C#")
        @profile.save
      end

      it { @project.technologies[0].name.should == "Ruby" }
      it { @project.technologies[1].name.should == "C#" }
      it { Technology.named("Ruby").count.should == 1 }      
      it { Technology.named("C#").count.should == 1 }      
    end
  end

end