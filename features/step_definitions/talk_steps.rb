Given /^I have a talk$/ do
  @talk = Factory.create(:talk, :profile => @profile)
end