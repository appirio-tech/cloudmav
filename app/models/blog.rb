class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  include CodeMav::Syncable
  
  field :title, :type => String
  field :url, :type => String
  field :rss, :type => String
  field :logo_url, :type => String
  
  references_many :posts
  referenced_in :profile, :inverse_of => :blog

  validates_presence_of :rss
  
end
