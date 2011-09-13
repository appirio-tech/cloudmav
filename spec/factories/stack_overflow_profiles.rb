FactoryGirl.define do
  factory :stack_overflow_profile do
    sequence(:stack_overflow_id){|n| n }
    association :profile, :factory => :profile
  end
end