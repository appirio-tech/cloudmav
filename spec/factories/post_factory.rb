Factory.define :post do |p|
  p.sequence(:title){|n| "my blog post #{n}"}
  p.written_on DateTime.parse("25/12/2010")
end