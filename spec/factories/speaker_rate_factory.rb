Factory.define :speaker_rate_profile do |p|
  p.sequence(:speaker_rate_id){|n| n }
  p.association :profile, :factory => :profile
end

