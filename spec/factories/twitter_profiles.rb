FactoryGirl.define do
  factory :twitter_profile do
    sequence(:username){|n| "username#{n}" }
    association :profile, :factory => :profile
  end
end
