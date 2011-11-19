FactoryGirl.define do
  factory :speaker_rate_profile do
    sequence(:speaker_rate_id){|n| n }
    association :profile, :factory => :profile
  end
end