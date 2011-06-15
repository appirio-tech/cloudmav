
Then /^I should have (\d+) coder points$/ do |number|
  profile = User.find(@user.id).profile
  profile.score(:coder_points).should == number.to_i
end

Then /^I should have (\d+) speaker points$/ do |number|
  profile = User.find(@user.id).profile
  profile.score(:speaker_points).should == number.to_i
end

Then /^I should have (\d+) social points$/ do |number|
  profile = User.find(@user.id).profile
  profile.score(:social_points).should == number.to_i
end



