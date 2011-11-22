When /^I sync my GitHub account$/ do
  VCR.use_cassette("github", :record => :new_episodes) do
    visit profile_syncable_path(@profile)
    fill_in "git_hub_profile_username", :with => 'rookieone'
    within("#sync_git_hub") do
      click_button "Sync"
    end
  end
end

Then /^I should have a GitHub profile$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.should_not be_nil
end

Then /^I should have a collection of my repos$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.repositories.count.should > 0
end

Then /^I should have coder points for my GitHub account$/ do
  @profile.reload
  @profile.score(:coder_points).should > 0
end

Then /^my GitHub profile should be tagged$/ do
  @profile.reload
  @profile.git_hub_profile.tags.count.should > 0
end

Then /^my coder profile should have my GitHub profile tags$/ do
  @profile.reload
  @profile.coder_profile.tags.count.should > 0
end

Then /^my profile should have my GitHub profile tags$/ do
  @profile.reload
  @profile.tags.count.should > 0
end

Then /^I should not see their GitHub profile$/ do
  And %Q{I should not see "GitHub"}
end

Given /^the other user has a GitHub profile$/ do
  VCR.use_cassette("other github", :record => :new_episodes) do
    Factory.create(:git_hub_profile, :username => "rookieone", :profile => @other_user.profile, :last_synced_date => DateTime.now)
    @other_user.profile.save
  end
end

Then /^I should see their GitHub profile$/ do
  And %Q{I should see "GitHub"}
end

Given /^I have a synced GitHub profile$/ do
  VCR.use_cassette("my github", :record => :new_episodes) do
    g = Factory.create(:git_hub_profile, :username => "rookieone", :profile => @profile, :last_synced_date => DateTime.now)
    @profile.save
    g.sync!
  end
end

When /^I edit my GitHub id$/ do
  VCR.use_cassette("edit github", :record => :new_episodes) do
    profile = Profile.find(@profile.id)
    @old_repositories = profile.git_hub_profile.repositories.to_a
    visit profile_syncable_path(@profile)
    fill_in "git_hub_profile_username", :with => "panesofglass"
    within("#sync_git_hub") do
      click_button "Sync"
    end
  end
end

Then /^my old GitHub repositories should be deleted$/ do
  old_ids = @old_repositories.map(&:id)
  GitHubRepository.any_in(:_id => old_ids).count.should == 0
end

Then /^I should have my new GitHub repositories$/ do
  @profile.reload
  @profile.git_hub_profile.repositories.count.should > 0
end

When /^I delete my GitHub profile$/ do
  visit profile_syncable_path(@profile)
  profile = Profile.find(@profile.id)
  @old_repositories = profile.git_hub_profile.repositories.to_a
  click_link "delete_git_hub"
end

Then /^I should not have a GitHub profile$/ do
  @profile.reload
  @profile.git_hub_profile.should be_nil
end