require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class BloggerSyncService
  
  def self.sync(blog)
    
    source = blog.rss + "?alt=rss&max-results=999"
    content = ""
    open(source) do |s| content = s.read end
    rss = RSS::Parser.parse(content, false)
    
    rss.items.each do |i|
      unless blog.posts.where(:title => i.title).first
        post = blog.posts.build
        post.title = i.title
        post.url = i.link
        post.written_on = i.date
        blog.profile.posts << post
      end
    end
  end
  
end