Factory.define :twitter_profile do |p|
  p.sequence(:username){|n| "twitter_username#{n}" } 
end
