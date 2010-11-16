Factory.define :user_group do |u|
  u.sequence(:name){ |n| "User Group #{n}" }
end