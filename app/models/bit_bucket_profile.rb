class BitBucketProfile
  include Mongoid::Document
  
  field :username
  field :repository_count
  field :followers_count
  field :url
  
  referenced_in :profile
  
  def sync!
    BitBucketService.sync(self)
    save!
  end
  
  def as_json(opts={})
    { 
      :bit_bucket_id => bit_bucket_id,
      :username => username,
      :repository_count => repository_count,
      :followers_count => followers_count,
      :url => url
    }
  end  
   
end