FactoryGirl.define do
  factory :skill do
    sequence(:name){|n| "Skill_#{n}"}
  end
end
