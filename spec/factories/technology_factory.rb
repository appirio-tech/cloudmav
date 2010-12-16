Factory.define :technology do |t|
  t.sequence(:name){ |n| "Technology #{n}" }
end