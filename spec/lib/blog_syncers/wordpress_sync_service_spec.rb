require 'spec_helper'

describe WordpressSyncService do
  
  describe "sync" do
    before(:each) do
      VCR.use_cassette("wordpress", :record => :new_episodes) do
        @profile = Factory.create(:profile)
        @blog = Blog.new
        @blog.blog_type = "Wordpress"
        @blog.rss = "http://claudiolassala.wordpress.com/"
        @profile.blogs << @blog
        WordpressSyncService.sync(@blog)
        @profile.save
      end
    end
    
    it { @blog.posts.count.should > 0 }
    it { @profile.posts.count.should > 0 }
  end
  
end
