class ResyncBlogJob
  @queue = :sync
  
  def self.perform(id)
    blog = Blog.find(id)    
    blog.posts.destroy_all
    
    blog.sync!
  end

end