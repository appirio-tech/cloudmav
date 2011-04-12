When /^I add a blog$/ do
  @blog = Factory.build(:blog)
  visit new_blog_path(:username => @profile.username)

  VCR.use_cassette("blog", :record => :all) do
    fill_in "blog_title", :with => @blog.title
    fill_in "blog_url", :with => "www.absentmindedcoder.com"
    select "Blogger", :from => "blog_type"
    click_button "Add"
  end
end

Then /^the blog should be added to my profile$/ do
  profile = User.find(@user.id).profile
  Blog.where(:title => @blog.title).first.should_not be_nil
  profile.blogs.select{ |b| b.title == @blog.title }.first.should_not be_nil
end

Given /^I have a blog$/ do
  @blog = Factory.build(:blog)
  @profile.blogs << @blog
  @blog.save!
  @profile.save!
end

When /^I add a post to my blog$/ do
  @post = Factory.build(:post)
  visit new_blog_post_path(@blog)
  fill_in "post_title", :with => @post.title
  fill_in "written_on", :with => @post.written_on
  click_button "Add"
end

Then /^the post should be added to my blog$/ do
  profile = User.find(@user.id).profile
  profile.blogs.first.posts.select{ |p| p.title == @post.title }.first.should_not be_nil
end

Then /^I should have (\d+) writer points$/ do |number|
  profile = User.find(@user.id).profile
  profile.score(:writer_points).should == number.to_i
end


