When /^I add a blog$/ do
  @blog = Factory.build(:blog)
  visit new_profile_blog_path(@profile)

  VCR.use_cassette("blog", :record => :new_episodes) do
    fill_in "blog_rss", :with => "http://www.theabsentmindedcoder.com/feeds/posts/default?alt=rss"
    click_button "Save"
  end
end

Then /^the blog should be added to my profile$/ do
  profile = Profile.find(@profile.id)
  profile.blogs.first.should_not be_nil
end

Then /^I should earned writer points for my blog$/ do
  profile = Profile.find(@profile.id)
  points = 10
  profile.posts.each {|p| points += 3 }
  profile.score(:writer_points).should == points
end

Then /^I should have posts$/ do
  profile = User.find(@user.id).profile
  profile.posts.count.should > 0
end

When /^I add a blog "([^"]*)"$/ do |rss|
  visit new_profile_blog_path(@profile)

  VCR.use_cassette("blog_#{rss}", :record => :new_episodes) do
    fill_in "blog_rss", :with => rss 
    click_button "Save"
  end
end

Given /^I have a blog$/ do
  VCR.use_cassette("my blog", :record => :new_episodes) do
    @blog = Factory.build(:blog, :profile => @profile, :rss => "http://www.theabsentmindedcoder.com/feeds/posts/default?alt=rss")
    @blog.save!
    @profile.save!
    @blog.sync!
  end
end

When /^I edit my blog$/ do
  VCR.use_cassette("edit blog", :record => :new_episodes) do
    profile = Profile.find(@profile.id)
    @old_posts = profile.posts.to_a
    visit edit_profile_blog_path(@profile, @blog)
    fill_in "blog_rss", :with => "http://feeds.feedburner.com/pseale"
    click_button "Save"
  end
end

Then /^my old posts should be deleted$/ do
  old_ids = @old_posts.map(&:id)
  Post.any_in(:_id => old_ids).count.should == 0
end

Then /^I should have my new Blog posts$/ do
  profile = Profile.find(@profile.id)
  profile.posts.count.should > 0
end

When /^I delete my blog$/ do
  visit profile_writing_path(@profile)
  profile = Profile.find(@profile.id)
  @old_posts = profile.posts.to_a
  within("##{@blog.id}") do
    click_link "delete"
  end
end

Then /^I should not have a blog$/ do
  Profile.find(@profile.id).blogs.count.should == 0
end


