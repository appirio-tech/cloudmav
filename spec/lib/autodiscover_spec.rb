#require 'spec_helper'
#
#describe "Autodiscover" do
#
#  describe "get users from SO" do
#    before(:each) do
#      page = nil
#      VCR.use_cassette("stack_overflow get all users", :record => :all) do
#        page = StackOverflow.get_all_users
#      end
#      Autodiscovery.process_stackoverflow_page(page)
#    end
#    it { Profile.count.should == 30 }
#  end
#
#  describe "autodiscover github" do
#    before(:each) do
#      @profile = Profile.create(:username => "whatever", 
#                                :name => "Jon Skeet",
#                                :gravatar_id => "6d8ebb117e8d83d74ea95fbdd0f87e13")
#      VCR.use_cassette("discover github", :record => :new_episodes) do
#        Autodiscovery.discover_github(@profile)
#      end
#      @profile = Profile.find(@profile.id)
#    end
#
#    it { @profile.git_hub_profile.should_not be_nil }
#  end
#
#  describe "autodiscover bitbucket" do
#    before(:each) do
#      @profile = Profile.create(:username => "rookieone")
#      VCR.use_cassette("discover bitbucket", :record => :new_episodes) do
#        Autodiscovery.discover_bitbucket(@profile)
#      end
#      @profile = Profile.find(@profile.id)
#    end
#
#    it { @profile.bitbucket_profile.should_not be_nil }
#  end
#
#end
