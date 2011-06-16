When /^I add a blog$/ do
  @blog = Factory.build(:blog)
  visit profile_writing_path(@profile)

  VCR.use_cassette("blog", :record => :new_episodes) do
    fill_in "blog_rss", :with => "http://www.theabsentmindedcoder.com/feeds/posts/default?alt=rss"
    click_button "Add"
  end
end

When /^I add a blog "([^"]*)"$/ do |rss|
  visit profile_writing_path(@profile)

  VCR.use_cassette("blog_#{rss}", :record => :new_episodes) do
    fill_in "blog_rss", :with => rss 
    click_button "Add"
  end
end

Then /^the blog should be added to my profile$/ do
  profile = Profile.find(@profile.id)
  profile.blogs.first.should_not be_nil
end

Given /^I have a blog$/ do
  VCR.use_cassette("my blog", :record => :new_episodes) do
    @blog = Factory.build(:blog, :rss => "http://www.theabsentmindedcoder.com/feeds/posts/default?alt=rss")
    @profile.blogs << @blog
    @blog.save!
    @profile.save!
    @blog.sync!
  end
end

When /^I add a post to my blog$/ do
  @post = Factory.build(:post)
  visit new_profile_blog_post_path(@blog)
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

Then /^I should have posts$/ do
  profile = User.find(@user.id).profile
  profile.posts.count.should > 0
end

Then /^I should earned writer points for my blog$/ do
  profile = Profile.find(@profile.id)
  points = 10
  profile.posts.each {|p| points += 3 }
  profile.score(:writer_points).should == points 
end

When /^I edit my blog$/ do
  VCR.use_cassette("edit blog", :record => :new_episodes) do
    profile = Profile.find(@profile.id)
    @old_posts = profile.posts.to_a
    @old_post_events = PostAddedEvent.all.to_a
    visit profile_writing_path(@profile)
    with_scope("#blog_#{@blog.id}") do
      fill_in "blog_rss", :with => "http://feeds.feedburner.com/pseale"
      click_button "blog_submit"
    end
  end
end

Then /^my old posts should be deleted$/ do
  old_ids = @old_posts.map(&:id)
  Post.any_in(_id: old_ids).count.should == 0
end

Then /^my old Blog events should be deleted$/ do
  old_ids = @old_post_events.map(&:id)
  PostAddedEvent.any_in(_id: old_ids).count.should == 0
end

Then /^I should have my new Blog posts$/ do
  profile = Profile.find(@profile.id)
  profile.posts.count.should > 0
end

