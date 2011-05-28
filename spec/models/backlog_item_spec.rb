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

    context "closer dates first" do
      before(:each) do
        @profile = Factory.create(:user).profile

        @net_conf = BacklogItem.create(:title => "dot Net Conf", :start_date => 3.months.from_now)
        @java_conf = BacklogItem.create(:title => "Java Conf", :start_date => 7.days.from_now)
        @ruby_conf = BacklogItem.create(:title => "Ruby Conf", :start_date => 6.months.from_now)

        @results = BacklogItem.recommended_items_for_profile(@profile)
      end

      it { @results.first.should == @java_conf }
    end

    context "nearby" do
      before(:each) do
        @profile = Factory.create(:user).profile
        @profile.coordinates = [-25, 95]
        @profile.save

        @net_conf = BacklogItem.create(:title => "dot Net Conf", :coordinates => [-40, 20])
        @java_conf = BacklogItem.create(:title => "Java Conf", :coordinates => [-25, 95])
        @ruby_conf = BacklogItem.create(:title => "Ruby Conf", :coordinates => [30, 10])

        @results = BacklogItem.recommended_items_for_profile(@profile)
      end

      it { @results.first.should == @java_conf }
    end
  end

end
