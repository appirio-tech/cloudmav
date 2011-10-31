require 'spec_helper'

describe "SyncBlogJob" do

  describe "Peters Blog" do
    before(:each) do
      VCR.use_cassette("blog_spec_peter", :record => :new_episodes) do
        @profile = Factory.create(:user).profile
        @blog = Blog.create(:rss => "http://feeds.feedburner.com/pseale", :profile => @profile)
        SyncBlogJob.perform(@blog.id)
        @blog.reload
      end
    end
  
    it { Post.count.should > 0 }
    it { @blog.posts.count.should > 0 }
    it { @blog.url.should_not be_nil }
    it { @blog.logo_url.should_not be_nil }
  end
  
  describe "Ryans Blog" do
    before(:each) do
      VCR.use_cassette("blog_spec_ryan", :record => :new_episodes) do
        @profile = Factory.create(:user).profile
        @blog = Blog.create(:rss => "http://wizardsofsmart.net/feed", :profile => @profile)
        SyncBlogJob.perform(@blog.id)
        @blog.reload
      end
    end
  
    it { Post.count.should > 0 }
    it { @blog.posts.count.should > 0 }
    it { @blog.posts.first.written_on.should_not be_nil }
  end
  
  describe "lazy coder" do
    before(:each) do
      VCR.use_cassette("blog_spec_lazycoder", :record => :new_episodes) do
        @profile = Factory.create(:user).profile
        @blog = Blog.create(:rss => "lazycoder.com/weblog/feed/", :profile => @profile)
        SyncBlogJob.perform(@blog.id)
        @blog.reload
      end
    end
      
    it { Post.count.should > 0 }
    it { @blog.posts.count.should > 0 }
    it { @blog.posts.first.written_on.should_not be_nil }
  end
  
  describe "koby" do
    before(:each) do
      VCR.use_cassette("blog_spec_koby", :record => :new_episodes) do
        @profile = Factory.create(:user).profile
        @blog = Blog.create(:rss => "http://www.mkoby.com/feed", :profile => @profile)
        SyncBlogJob.perform(@blog.id)
        @blog.reload
      end
    end
      
    it { Post.count.should > 1 }
    it { @blog.posts.count.should > 1 }
    it { @blog.posts.first.written_on.should_not be_nil }
  end

  describe "codejunkies" do
    before(:each) do
      VCR.use_cassette("blog_spec_codejunkies", :record => :new_episodes) do
        @profile = Factory.create(:user).profile
        @blog = Blog.create(:rss => "www.codejunkies.se", :profile => @profile)
        SyncBlogJob.perform(@blog.id)
        @blog.reload
      end
    end
      
    it { Post.count.should > 1 }
    it { @blog.posts.count.should > 1 }
    it { @blog.posts.first.written_on.should_not be_nil }
  end
end
