Factory.define :project do |p|
  p.sequence(:name){|n| "project #{n}"}
  p.start_date 6.months.ago
  p.end_date 1.month.ago
end