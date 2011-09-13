When /^I sync my CoderWall account$/ do
  VCR.use_cassette("coder_wall", :record => :new_episodes) do
    visit new_profile_coder_wall_profile_path(@profile)
    fill_in "coder_wall_profile_username", :with => 'rookieone'
    click_button "Save"
  end
end

Then /^I should have a CoderWall profile$/ do
  @profile.reload
  @profile.coder_wall_profile.should_not be_nil
end

Then /^I should have coder points for CoderWall$/ do
  profile = User.find(@user.id).profile
  expected_points = 10 + (5 * profile.coder_wall_profile.badges_count) 
  profile.score(:coder_points).should == expected_points
end

Then /^I should have badges on my CoderWall profile$/ do
  profile = Profile.find(@profile.id)
  profile.coder_wall_profile.badges.count.should > 0
end
