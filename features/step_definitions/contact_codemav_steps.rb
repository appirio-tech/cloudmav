When /^I contact CodeMav$/ do
  visit contact_path
  @contact = Factory.build(:contact)
  fill_in "contact_name", :with => @contact.name
  fill_in "contact_email", :with => @contact.email
  fill_in "contact_subject", :with => @contact.subject
  fill_in "contact_description", :with => @contact.description
  click_button "Submit"
end

Then /^CodeMav should receive a contact email$/ do
  email = ActionMailer::Base.deliveries.first
  email.should_not be_nil
  email.subject.should == "Contact : #{@contact.subject}"
  email.to.should == ["contact@codemav.com"]
  email.body.should include @contact.name
  email.body.should include @contact.email
  email.body.should include @contact.subject
  email.body.should include @contact.description
end

