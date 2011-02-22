class SlideShareProfile
  include Mongoid::Document
  include Mongoid::Timestamps
  include CodeMav::Eventable
  include CodeMav::Synchable
  
  field :slide_share_username
  field :url
  
  referenced_in :profile, :inverse_of => :slide_share_profile
 
  def as_json(opts={})
    { 
      :slide_share_username => slide_share_username
    }
  end
  
end
