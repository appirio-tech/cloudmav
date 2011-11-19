FactoryGirl.define do
  factory :slide_share_profile do
    sequence(:slide_share_username){|n| "username#{n}" }
    association :profile, :factory => :profile
  end
end