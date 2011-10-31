class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Syncable
  
  field :title, :type => String
  field :url, :type => String
  field :rss, :type => String
  field :logo_url, :type => String
  
  has_many :posts
  belongs_to :profile

  validates_presence_of :rss
  
  before_save :fix_rss
  
  def fix_rss
    unless self.rss.starts_with?("http://")
      self.rss = "http://#{rss}"
    end
    
    return if rss_exists? self.rss
    
    blogger_rss = self.rss + "/feeds/posts/default"
    if rss_exists? blogger_rss
      self.rss = blogger_rss
    end
  end
  
  def rss_exists?(url)
    SimpleRSS.parse open(url)
    true
  rescue
    false
  end
end
