require 'spec_helper'

describe BloggerSyncService do
  
  describe "sync" do
    before(:each) do
      @profile = Factory.create(:profile)
      @blog = Blog.new
      @blog.blog_type = "Blogger"
      @blog.rss = "http://www.theabsentmindedcoder.com/feeds/posts/default"
      @profile.blogs << @blog
      BloggerSyncService.sync(@profile, @blog)
      @profile.save
    end
    
    it { @blog.posts.count.should > 0 }
  end
  
end