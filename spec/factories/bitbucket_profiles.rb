FactoryGirl.define do
  factory :bitbucket_profile do
    sequence(:username){|n| "username#{n}" }
    association :profile, :factory => :profile
  end
end