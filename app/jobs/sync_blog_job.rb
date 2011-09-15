require "open-uri"

class SyncBlogJob
  @queue = :sync
  
  def self.perform(id)
    blog = Blog.find(id)
    profile = blog.profile
    
    unless blog.rss.starts_with?("http://")
      blog.rss = "http://#{blog.rss}"
    end

    rss = SimpleRSS.parse open(blog.rss)
    return if rss.nil?

    blog.title = rss.feed.send(:title) if rss.feed.respond_to?(:title, :include_private => true)
    blog.url = rss.feed.send(:link) if rss.feed.respond_to?(:link, :include_private => true)
    blog.logo_url = rss.feed.send(:logo) if rss.feed.respond_to?(:logo, :include_private => true)
  
    rss.items.each do |i|
      unless has_post?(blog, i)
        pub_date = i.published || i.pubDate
        blog.posts.create(
          :imported_id => i.id,
          :title => i.title,
          :url => i.link,
          :written_on => pub_date,
          :profile => blog.profile)
      end
    end
    blog.save    
    
    profile.award_badge("iBlog", :description => "For having a blog")
    profile.save
    
    profile.calculate_score!
  end
  
  def self.has_post?(blog, rss_item)
    post = nil
    unless rss_item.id.nil?
      post = blog.posts.where(:imported_id => rss_item.id).first
    else
      post = blog.posts.where(:title => rss_item.title).first
    end
    return !post.nil?
  end
end