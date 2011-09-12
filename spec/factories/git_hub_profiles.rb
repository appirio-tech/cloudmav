FactoryGirl.define do
  factory :git_hub_profile do
    sequence(:username){|n| "username#{n}" }
    association :profile, :factory => :profile
  end
end