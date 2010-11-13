require 'spec_helper'

describe Profile do
  
  describe "display name" do
    context "no name and no email" do
      it "should use the user email address" do
        user = User.new(:email => "test@email.com")
        profile = Profile.new(:user => user)
        profile.display_name.should == "test@email.com"
      end
    end
    
    context "no name" do
      it "should use the profile email address" do
        user = User.new(:email => "test@email.com")
        profile = Profile.new(:user => user)
        profile.email = "somethingnew@email.com"
        profile.display_name.should == "somethingnew@email.com"
      end
    end
    
    context "use name" do
      it "should use the profile name" do
        user = User.new(:email => "test@email.com")
        profile = Profile.new(:user => user)
        profile.name = "John Doe"
        profile.display_name.should == "John Doe"
      end
    end
    
    context "empty name" do
      it "should use the profile email address" do
        user = User.new(:email => "test@email.com")
        profile = Profile.new(:user => user)
        profile.name = ""
        profile.display_name.should == "test@email.com"
      end
    end
  end
  
end