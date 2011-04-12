require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class BloggerSyncService
  
  def self.sync(blog)
    begin
      blog.rss = "http://" + blog.url + "/feeds/posts/default?alt=rss&max-results=999"
      content = ""
      open(blog.rss) do |s| content = s.read end
      rss = RSS::Parser.parse(content, false)

      return if rss.nil?
      
      if blog.title.nil? || blog.title.blank?
        blog.title = rss.channel.title
      end
    
      rss.items.each do |i|
        unless blog.posts.where(:title => i.title).first
          post = Post.new
          post.title = i.title
          post.url = i.link
          post.written_on = i.date
          post.blog = blog
          post.profile = blog.profile
          post.save
        end
      end
      blog.save
    rescue
      puts "Blog Sync error: #{$!}"
    end
  end
  
end
