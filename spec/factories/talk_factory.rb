Factory.define :talk do |t|
  t.sequence(:title){|n| "Talk #{n}"}
  t.description "description of the talk"
  t.sequence(:permalink){|n| "talk_#{n}"}
  t.slides_url "slides.com"
end
