Factory.define :job do |j|
  j.title "Developer"
  j.description "I did awesome stuff"
  j.association :company, :factory => :company
  j.start_date 6.months.ago
  j.end_date 1.month.ago
end