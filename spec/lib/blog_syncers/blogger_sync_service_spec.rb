require 'spec_helper'

describe BloggerSyncService do
  
  describe "sync" do
    context "typical" do
      before(:each) do
        VCR.use_cassette("blogger", :record => :new_episodes) do
          @profile = Factory.create(:user).profile
          @blog = Blog.new
          @blog.blog_type = "Blogger"
          @blog.url = "www.theabsentmindedcoder.com"
          @profile.blogs << @blog
          BloggerSyncService.sync(@blog)
          @profile.save
        end
      end
      
      it { @blog.posts.count.should > 0 }
      it { @profile.posts.count.should > 0 }
    end

    context "no title" do
      before(:each) do
        VCR.use_cassette("blogger", :record => :new_episodes) do
          @profile = Factory.create(:user).profile
          @blog = Blog.new
          @blog.blog_type = "Blogger"
          @blog.url = "www.theabsentmindedcoder.com"
          @profile.blogs << @blog
          BloggerSyncService.sync(@blog)
          @profile.save
        end
      end
      
      it { @blog.title.should == "The Absent Minded Coder" }
      it { @blog.posts.count.should > 0 }
      it { @profile.posts.count.should > 0 }
    end
  end

end
