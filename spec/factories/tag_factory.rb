Factory.define :tag do |t|
  t.sequence(:name){|n| "tag_#{n}"}
end