class BlogSyncEvent < SyncEvent

  referenced_in :blog, :inverse_of => :events

  def has_post?(rss_item)
    post = nil
    unless rss_item.id.nil?
      post = blog.posts.where(:imported_id => rss_item.id).first
    else
      post = blog.posts.where(:title => rss_item.title).first
    end
    return !post.nil?
  end

  def sync
    unless blog.rss.starts_with?("http://")
      blog.rss = "http://#{blog.rss}"
    end

    rss = SimpleRSS.parse open(blog.rss)
    return if rss.nil?

    blog.title = rss.feed.send(:title) if rss.feed.respond_to?(:title, :include_private => true)
    blog.url = rss.feed.send(:link) if rss.feed.respond_to?(:link, :include_private => true)
    blog.logo_url = rss.feed.send(:logo) if rss.feed.respond_to?(:logo, :include_private => true)
  
    rss.items.each do |i|
      unless has_post?(i)
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
  end

#  def sync
#    begin
#      puts "SYNC"
#    content = ""
#    open(blog.rss) do |s| content = s.read end
#    rss = RSS::Parser.parse(content, false)
#
#    return if rss.nil?
#    
#    if blog.title.nil? || blog.title.blank?
#      blog.title = rss.channel.title
#    end
#  
#    rss.items.each do |i|
#      unless blog.posts.where(:title => i.title).first
#        post = Post.new
#        post.title = i.title
#        post.url = i.link
#        post.written_on = i.date
#        post.blog = blog
#        post.profile = blog.profile
#        post.save
#      end
#    end
#    blog.save
#  rescue => details
#    puts "Error : #{details}"
#  end
#end

end
