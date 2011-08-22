Factory.define :git_hub_profile do |p|
  p.sequence(:username){|n| "username#{n}" }
  p.association :profile, :factory => :profile
end

