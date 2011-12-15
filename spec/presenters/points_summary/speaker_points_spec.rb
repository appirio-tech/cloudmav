require 'spec_helper'

describe "Points Summary for Speaker Points" do
  before(:each) do
    @profile = Factory.create(:user).profile    
  end
  
  context "Two Talk" do
    before(:each) do
      @talk1 = Factory.create(:talk, :profile => @profile, :title => "Talking is Great")
      @profile.earn(10, :speaker_points, "For talk '#{@talk1.title}'", @talk1)
      @talk2 = Factory.create(:talk, :profile => @profile, :title => "Best talk Evar")
      @profile.earn(10, :speaker_points, "For talk '#{@talk2.title}'", @talk2)
      @profile.reload
      @list = PointsSummaryPresenter.get_list(@profile)
    end
    
    it { @list[0][:point_type].should == "speaker_points" }
    it { @list[0][:scorings][0].name.should == "For talk '#{@talk1.title}'" } 
    it { @list[0][:scorings][1].name.should == "For talk '#{@talk2.title}'" }            
  end
  
end