When /^I add a blog$/ do
  @blog = Factory.build(:blog)
  visit profile_writing_path(@profile)

  VCR.use_cassette("blog", :record => :new_episodes) do
    fill_in "blog_rss", :with => "http://www.theabsentmindedcoder.com/feeds/posts/default?alt=rss"
    click_button "Add"
  end
end

Then /^the blog should be added to my profile$/ do
  profile = Profile.find(@profile.id)
  profile.blogs.first.should_not be_nil
end

Given /^I have a blog$/ do
  @blog = Factory.build(:blog, :rss => "http://www.theabsentmindedcoder.com/feeds/posts/default?alt=rss")
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


