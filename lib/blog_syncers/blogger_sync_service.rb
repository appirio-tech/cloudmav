require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class BloggerSyncService
  
  def self.sync(blog)
    
    source = blog.rss + "?alt=rss&max-results=999"
    puts "source = #{source}"
    content = ""
    open(source) do |s| content = s.read end
    rss = RSS::Parser.parse(content, false)
    
    rss.items.each do |i|
      unless blog.posts.where(:title => i.title).first
        post = blog.posts.build
        post.title = i.title
        post.url = i.link
        post.written_on = i.date
        # blog.posts << post
        # post.save
        # blog.save
      end
    end
    # puts "rss = #{rss.inspect}"
    
    # print "title of first item: ", rss.items[0].title, "\n"
    # print "link of first item: ", rss.items[0].link, "\n"
    # print "description of first item: ", rss.items[0].description, "\n"
    # print "date of first item: ", rss.items[0].date, "\n"
  end
  
end