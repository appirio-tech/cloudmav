Then /^I should have (\d+) coder points$/ do |number|
  @profile.reload
  @profile.score(:coder_points).should == number.to_i
end