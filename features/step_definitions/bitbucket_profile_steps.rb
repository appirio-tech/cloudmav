When /^I sync my Bitbucket account$/ do
  VCR.use_cassette("bitbucket", :record => :new_episodes) do
    visit new_profile_bitbucket_profile_path(@profile)
    fill_in "bitbucket_profile_username", :with => 'rookieone'
    click_button "Save"
  end
end

Then /^I should have a Bitbucket profile$/ do
  Profile.find(@profile.id).bitbucket_profile.should_not be_nil
end

Then /^I should have the collection of my Bitbucket repos$/ do
  profile = Profile.find(@profile.id)
  profile.bitbucket_profile.repositories.count.should > 0
  BitbucketRepositoryAddedEvent.count.should > 0
end

Given /^the other user has a Bitbucket profile$/ do
  VCR.use_cassette("other bitbucket", :record => :new_episodes) do
    Factory.create(:bitbucket_profile, :username => "rookieone", :profile => @other_user.profile, :last_synced_date => DateTime.now)
    @other_user.profile.save
  end
end

Then /^I should not see their Bitbucket profile$/ do
  And %Q{I should not see "Go to my Bitbucket Profile"}
end

Then /^I should see their Bitbucket profile$/ do
  And %Q{I should see "Go to my Bitbucket Profile"}
end


