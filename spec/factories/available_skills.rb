FactoryGirl.define do
  factory :available_skill do
    sequence(:name){|n| "Skill_#{n}"}
  end
end
