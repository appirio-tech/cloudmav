Factory.define :experience do |e|
  e.duration Duration.new(5000)
  e.association :technology, :factory => :technology
end