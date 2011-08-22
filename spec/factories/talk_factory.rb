Factory.define :talk do |t|
  t.sequence(:title){|n| "Talk #{n}"}
  t.description "description of the talk"
  t.slides_url "slides.com"
end
