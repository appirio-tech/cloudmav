require 'spec_helper'

describe "Blog" do

  describe "Peters Blog" do
    before(:each) do
      VCR.use_cassette("blog_spec_peter", :record => :new_episodes) do
        @profile = Factory.create(:user).profile
        @blog = Blog.create(:rss => "http://feeds.feedburner.com/pseale", :profile => @profile)
        @event = BlogSyncEvent.new(:blog => @blog)
        @event.subject_class_name = "Blog"
        @event.subject_id = @blog.id
        @event.profile = @blog.profile
        @event.save

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
        @event = BlogSyncEvent.new(:blog => @blog)
        @event.subject_class_name = "Blog"
        @event.subject_id = @blog.id
        @event.profile = @blog.profile
        @event.save
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
        @event = BlogSyncEvent.new(:blog => @blog)
        @event.subject_class_name = "Blog"
        @event.subject_id = @blog.id
        @event.profile = @blog.profile
        @event.save
        @blog.reload
      end
    end
      
    it { Post.count.should > 0 }
    it { @blog.posts.count.should > 0 }
    it { @blog.posts.first.written_on.should_not be_nil }
  end

  #describe "koby" do
  #  before(:each) do
  #    VCR.use_cassette("blog_spec_koby", :record => :new_episodes) do
  #      @blog = Blog.create(:rss => "http://www.mkoby.com/feed")
  #      @event = BlogSyncEvent.create(:blog => @blog)
  #      @event.sync
  #      @blog.reload
  #    end
  #  end
  #    
  #  it { Post.count.should > 1 }
  #  it { @blog.posts.count.should > 1 }
  #  it { @blog.posts.first.written_on.should_not be_nil }
  #end

end
