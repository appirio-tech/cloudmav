require 'spec_helper'

describe "Blog" do

  describe "Peters Blog" do
    before(:each) do
      VCR.use_cassette("blog_spec_peter", :record => :new_episodes) do
        @blog = Blog.create(:rss => "http://feeds.feedburner.com/pseale")
        @event = BlogSyncEvent.create(:blog => @blog)
        @event.sync
        @blog.reload
      end
    end
  
    it { Post.count.should > 0 }
    it { @blog.posts.count.should > 0 }
  end

  describe "Ryans Blog" do
    before(:each) do
      VCR.use_cassette("blog_spec_ryan", :record => :new_episodes) do
        @blog = Blog.create(:rss => "http://wizardsofsmart.net/feed")
        @event = BlogSyncEvent.create(:blog => @blog)
        @event.sync
        @blog.reload
      end
    end
  
    it { Post.count.should > 0 }
    it { @blog.posts.count.should > 0 }

  end

end
