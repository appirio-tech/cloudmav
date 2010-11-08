class StackOverflowProfile
  include Mongoid::Document
  
  field :stack_overflow_id
  field :reputation
  field :url
  field :badge_html
  
  referenced_in :profile
end