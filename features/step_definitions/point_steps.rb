Then /^I should have (\d+) coder points$/ do |number|
  @profile.reload
  @profile.score(:coder_points).should == number.to_i
end

Then /^I should have (\d+) speaker points$/ do |number|
  @profile.reload
  @profile.score(:speaker_points).should == number.to_i
end