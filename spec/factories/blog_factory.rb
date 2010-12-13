Factory.define :blog do |b|
  b.sequence(:title){|n| "My Blog #{n}"}
  b.url "www.myblog.com"
end