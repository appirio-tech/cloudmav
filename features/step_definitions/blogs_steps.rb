When /^I add a blog$/ do
  @blog = Factory.build(:blog)
  visit new_my_blog_path
  fill_in :title, :with => @blog.title
  fill_in :url, :with => @blog.url
  click_button "Add"
  And %Q{I should be redirected}
end

Then /^the blog should be added to my profile$/ do
  profile = User.find(@user.id).profile
  profile.blogs.select{ |b| b.title == @blog.title }.first.should_not be_nil
end
