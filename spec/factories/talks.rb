FactoryGirl.define do
  factory :talk do
    sequence(:title){|n| "Talk #{n}"}
    description "description of the talk"
    sequence(:permalink){|n| "talk_#{n}"}
    slides_url "slides.com"
  end
end
