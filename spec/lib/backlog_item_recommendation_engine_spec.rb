require 'spec_helper'

describe BacklogItemRecommendationEngine do

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

        BacklogItemRecommendationEngine.build_recommendations_for_profile!(@profile.id)
        @profile.reload
        @recommendations = @profile.backlog_item_recommendations.order_by([:score, :desc]).map(&:backlog_item)
      end

      it { @recommendations.first.should == @ruby_conf }
    end

    context "closer dates first" do
      before(:each) do
        @profile = Factory.create(:user).profile

        @net_conf = BacklogItem.create(:title => "dot Net Conf", :start_date => 3.months.from_now)
        @java_conf = BacklogItem.create(:title => "Java Conf", :start_date => 7.days.from_now)
        @ruby_conf = BacklogItem.create(:title => "Ruby Conf", :start_date => 6.months.from_now)

        BacklogItemRecommendationEngine.build_recommendations_for_profile!(@profile.id)
        @profile.reload
        @recommendations = @profile.backlog_item_recommendations.order_by([:score, :desc]).map(&:backlog_item)
      end

      it { @recommendations.first.should == @java_conf }
    end

    context "nearby" do
      before(:each) do
        @profile = Factory.create(:user).profile
        @profile.lat = -25
        @profile.lng = 95
        @profile.coordinates = [-25, 95]
        @profile.save

        @net_conf = BacklogItem.create(:title => "dot Net Conf", :location => "Somewhere", :coordinates => [-40, 20])
        @java_conf = BacklogItem.create(:title => "Java Conf", :location => "Somewhere", :coordinates => [-25, 95])
        @ruby_conf = BacklogItem.create(:title => "Ruby Conf", :location => "Somewhere", :coordinates => [30, 10])

        BacklogItemRecommendationEngine.build_recommendations_for_profile!(@profile.id)
        @profile.reload
        @recommendations = @profile.backlog_item_recommendations.order_by([:score, :desc]).map(&:backlog_item)
      end

      it { @recommendations.first.should == @java_conf }
    end
  end

end
