Then /^I should have (\d+) coder points$/ do |number|
  @profile.reload
  @profile.score(:coder_points).should == number.to_i
end

Then /^I should have (\d+) speaker points$/ do |number|
  @profile.reload
  @profile.score(:speaker_points).should == number.to_i
end

Then /^I should have (\d+) writing points$/ do |number|
  @profile.reload
  @profile.score(:writer_points).should == number.to_i
end

Then /^I should have (\d+) social points$/ do |number|
  @profile.reload
  @profile.score(:social_points).should == number.to_i
end

Then /^I should have (\d+) experience points$/ do |number|
  @profile.reload
  @profile.score(:experience_points).should == number.to_i
end

Then /^I should have speaker points$/ do
  @profile.reload
  @profile.score(:speaker_points).should > 0
end

Then /^I should have (\d+) total points$/ do |number|
  @profile.reload
  @profile.total_score.should == number.to_i
end
