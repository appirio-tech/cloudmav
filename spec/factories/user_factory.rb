Factory.define :user do |u|
  u.sequence(:email){ |n| "test#{n}@email.com" }
  u.password "secret"
  u.password_confirmation "secret"
end

