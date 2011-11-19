# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "test#{n}@email.com" }
    password "secret"
    password_confirmation "secret"
  end
end