FactoryGirl.define do
  factory :blog do
    sequence(:title){|n| "My Blog #{n}"}
    url "www.myblog.com"
  end
end
