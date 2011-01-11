class Blog
  include Mongoid::Document
  
  field :title, :type => String
  field :url, :type => String
  field :rss, :type => String
  field :blog_type, :type => String
  
  references_many :posts
  referenced_in :profile, :inverse_of => :blog

  BLOG_PROVIDERS = ["Blogger", "Wordpress"]
  
  def self.get_providers
    BLOG_PROVIDERS
  end

  def sync!
    if self.blog_type == "Blogger"
      BloggerSyncService.sync(self)
    elsif self.blog_type == "Wordpress"
      WordpressSyncService.sync(self)
    end
  end
  
end