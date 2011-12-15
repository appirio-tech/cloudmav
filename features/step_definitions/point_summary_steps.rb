Given /^I have earned speaker points$/ do
  @talks = []
  @talks << Factory.create(:talk, :profile => @profile)
  @talks << Factory.create(:talk, :profile => @profile)  
  @profile.earn(10, :speaker_points, "for being awesome", @talks[0])
  @profile.earn(20, :speaker_points, "for being awesome", @talks[1])  
end

When /^I view my point summary$/ do
  visit profile_points_summary_path(@profile)
  And "show me the page"
end

Then /^I should see how I earned my speaker points$/ do
  pending # express the regexp above with the code you wish you had
end