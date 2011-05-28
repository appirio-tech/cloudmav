require 'spec_helper'

describe BacklogItem do

  describe "recommended_items_for_profile" do
    context "similar tags first" do
      before(:each) do
        @profile = Factory.create(:user).profile
        @profile.tags_text = "ruby"
        @profile.save
        @profile.retag!

        @net_conf = BacklogItem.create(:title => "dot Net Conf", :tags_text => ".Net")
        @net_conf.retag!
        @java_conf = BacklogItem.create(:title => "Java Conf", :tags_text => "java")
        @java_conf.retag!
        @ruby_conf = BacklogItem.create(:title => "Ruby Conf", :tags_text => "ruby")
        @ruby_conf.retag!

        @results = BacklogItem.recommended_items_for_profile(@profile)
      end

      it { @results.first.should == @ruby_conf }
    end

  end

end
