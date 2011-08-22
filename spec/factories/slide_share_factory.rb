Factory.define :slide_share_profile do |p|
  p.sequence(:slide_share_username){|n| "username#{n}" }
  p.association :profile, :factory => :profile
end


