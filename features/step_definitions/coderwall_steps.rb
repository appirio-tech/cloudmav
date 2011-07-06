When /^I sync my CoderWall account$/ do
  VCR.use_cassette("coder_wall", :record => :new_episodes) do
    visit new_profile_coder_wall_profile_path(@profile)
    fill_in "coder_wall_profile_username", :with => 'rookieone'
    click_button "Save"
  end
end

Then /^I should have a CoderWall profile$/ do
  profile = User.find(@user.id).profile
  profile.coder_wall_profile.should_not be_nil
end

