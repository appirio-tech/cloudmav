Given /^there is another user$/ do
  @other_user = Factory.create(:user)
end

When /^I view their code profile$/ do
  visit profile_code_path(@other_user.profile)
end

When /^I view their knowledge profile$/ do
  visit profile_knowledge_path(@other_user.profile)
end