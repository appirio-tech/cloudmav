When /^my profile is scored$/ do
  @profile.calculate_score!
end


Then /^my talk should have a score$/ do
  @profile.reload
  @profile.talks.first.total_score.should > 0
end
