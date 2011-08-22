# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)

u = User.new
u.username = "kevinwlee"
u.email = "kevinwlee@chaione.com"
u.password = "test123"
u.password_confirmation = "test123"
u.save

p = u.profile
p.name = "Kevin W Lee"

job = Job.new
job.company_name = "ChaiOne"
job.start_date = DateTime.parse("1/8/2010")
job.end_date = DateTime.parse("13/1/2011")
p.jobs << job
job.save
job.tag! "iPhone"

u = User.new
u.username = "flux88"
u.email = "flux88@chaione.com"
u.password = "test123"
u.password_confirmation = "test123"
u.save

p = u.profile
p.name = "Ben Scheirman"

job = Job.new
job.company_name = "ChaiOne"
job.start_date = DateTime.parse("1/10/2009")
job.end_date = DateTime.parse("13/1/2011")
p.jobs << job
job.save
job.tag! "iPhone"
job.tag! "Rails"

########################## CLAUDIO

u = User.new
u.username = "claudiolassala"
u.email = "claudiolassala@example.com"
u.password = "test123"
u.password_confirmation = "test123"
u.save

p = u.profile
p.name = "Claudio Lassala"

talk = Talk.new
p.talks << talk
talk.title = "Design Patterns"
talk.description = "Design patterns and stuff and how they are awesome"
talk.tags_text = "Design Patters, OOP, C#"
talk.save

talk = Talk.new
p.talks << talk
talk.title = "OOP"
talk.description = "SOLID and OOP"
talk.tags_text = "OOP, C#"
talk.save

job = Job.new
job.company_name = "EPS"
job.start_date = DateTime.parse("1/10/2006")
job.end_date = DateTime.parse("13/1/2011")
p.jobs << job
job.save
job.tag! "WPF"
job.tag! "C#"

Company.all.each do |c|
  c.calculate_tags
  c.save
end
Profile.all.each do |p|
  p.calculate_tags
  p.save
end