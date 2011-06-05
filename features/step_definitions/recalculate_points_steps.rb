Given /^I have earned some points$/ do
  VCR.use_cassette("points stackoverflow", :record => :all) do
    so = Factory.create(:stack_overflow_profile, :stack_overflow_id => "60336", :profile => @profile, :last_synced_date => DateTime.now)
    @profile.save
    so.sync!
  end

  VCR.use_cassette('points speaker_rate ', :record => :new_episodes) do
    sp = Factory.create(:speaker_rate_profile, :speaker_rate_id => "10082", :profile => @profile)
    @profile.save
    sp.sync!
  end
end

When /^my score is recalculated$/ do
  profile = Profile.find(@profile.id)
  @previous_score = profile.total_score
  profile.recalculate_score!
end

Then /^my score should be the same$/ do
  Profile.find(@profile.id).total_score.should == @previous_score
end

