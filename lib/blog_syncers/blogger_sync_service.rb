require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class BloggerSyncService
  
  def self.sync(blog)
    blog.rss = "http://" + blog.url + "/feeds/posts/default?alt=rss&max-results=999"
    content = ""
    open(blog.rss) do |s| content = s.read end
    rss = RSS::Parser.parse(content, false)
    
    rss.items.each do |i|
      unless blog.posts.where(:title => i.title).first
        post = Post.new
        post.title = i.title
        post.url = i.link
        post.written_on = i.date
        post.blog = blog
        post.profile = blog.profile
      end
    end
    blog.save
  end
  
end