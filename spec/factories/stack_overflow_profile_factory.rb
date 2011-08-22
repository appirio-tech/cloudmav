Factory.define :stack_overflow_profile do |p|
  p.sequence(:stack_overflow_id){|n| n}
  p.association :profile, :factory => :profile
end