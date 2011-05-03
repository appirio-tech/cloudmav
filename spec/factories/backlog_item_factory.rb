Factory.define :backlog_item do |b|
  b.sequence(:title){|n| "title #{n}"}
end
