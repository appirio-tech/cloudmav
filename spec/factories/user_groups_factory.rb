Factory.define :user_group do |u|
  u.sequence(:name){ |n| "User Group #{n}" }
  u.lat 100
  u.lng 100
  u.location "Someplace"
end