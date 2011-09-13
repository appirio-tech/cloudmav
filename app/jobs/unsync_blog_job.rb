class UnsyncBlogJob
  @queue = :sync
  
  def self.perform(id)
    blog = Blog.find(id)    
    profile = blog.profile
    
    blog.posts.destroy_all
    
    profile.remove_badge("iBlog")
    
    blog.destroy
    
    profile.calculate_score!
  end

end