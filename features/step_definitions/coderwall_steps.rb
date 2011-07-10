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

Then /^I should have coder points for CoderWall$/ do
  profile = User.find(@user.id).profile
  expected_points = 10 + (5 * profile.coder_wall_profile.badges_count) 
  profile.score(:coder_points).should == expected_points
end

Then /^I should have badges on my CoderWall profile$/ do
  profile = Profile.find(@profile.id)
  profile.coder_wall_profile.badges.count.should > 0
end

Then /^I should not see their CoderWall profile$/ do
  And %Q{I should not see "Go to my Coderwall Profile"}
end

Given /^the other user has a CoderWall profile$/ do
  VCR.use_cassette("other coderwall", :record => :all) do
    coder_wall = CoderWallProfile.new(:username => "rookieone")
    @other_user.profile.coder_wall_profile = coder_wall
    coder_wall.last_synced_date = DateTime.now
    coder_wall.save
    @other_user.profile.save
  end
end

Then /^I should see their CoderWall profile$/ do
  And %Q{I should see "Go to my Coderwall Profile"}
end

Given /^I have a CoderWall profile$/ do
  VCR.use_cassette("my coderwall", :record => :new_episodes) do
    c = CoderWallProfile.new
    c.username = "rookieone"
    @profile.coder_wall_profile = c
    @profile.save
    c.save
    c.sync!
  end
end

When /^I edit my CoderWall username$/ do
  VCR.use_cassette("edit coderwall", :record => :new_episodes) do
    profile = Profile.find(@profile.id)
    @old_badges = profile.coder_wall_profile.badges.to_a
    visit profile_code_path(@profile)
    fill_in "coder_wall_profile_username", :with => "subdigital"
    with_scope("#sync_coder_wall") do
      click_button "Save"
    end
  end
end

Then /^my old CoderWall badges should be deleted$/ do
  profile = Profile.find(@profile.id)
  profile.coder_wall_profile.badges.count.should_not == @old_badges.count
end

Then /^I should have my new CoderWall badges$/ do
  profile = Profile.find(@profile.id)
  profile.coder_wall_profile.badges.count.should > 0
end

When /^I delete my CoderWall profile$/ do
  visit profile_code_path(@profile)
  profile = Profile.find(@profile.id)
  click_link "delete_coder_wall"
end

Then /^I should not have a CoderWall profile$/ do
  Profile.find(@profile.id).coder_wall_profile.should be_nil
end

