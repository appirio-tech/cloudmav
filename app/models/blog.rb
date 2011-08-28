class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  include CodeMav::Syncable
  
  field :title, :type => String
  field :url, :type => String
  field :rss, :type => String
  field :logo_url, :type => String
  
  has_many :posts
  belongs_to :profile

  validates_presence_of :rss
  
end
