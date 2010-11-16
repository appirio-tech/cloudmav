Factory.define :company do |c|
  c.sequence(:name){|n| "Company #{n} Inc."}
end