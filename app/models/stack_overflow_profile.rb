class StackOverflowProfile
  include Mongoid::Document
  
  field :stack_overflow_id
  field :reputation
  field :url
  field :badge_html
  
  referenced_in :profile
  
  def as_json(opts={})
    { 
      :stack_overflow_id => stack_overflow_id,
      :reputation => reputation,
      :url => url,
      :badge_html => badge_html
    }
  end
end