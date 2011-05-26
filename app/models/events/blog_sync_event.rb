class BlogSyncEvent < SyncEvent

  referenced_in :blog, :inverse_of => :events

  def sync
    rss = SimpleRSS.parse open(blog.rss)
    return if rss.nil?

    if blog.title.nil? || blog.title.blank?
      blog.title = rss.channel.send(:title)
    end
  
    rss.items.each do |i|
      unless blog.posts.where(:imported_id => i.id).first
        blog.posts.create(
          :imported_id => i.id,
          :title => i.title,
          :url => i.link,
          :written_on => i.published,
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
