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

project = Project.new
project.name = "Bizeeti"
project.start_date = DateTime.parse("1/11/2010")
project.end_date = DateTime.parse("13/1/2011")
p.projects << project
project.save
project.set_technologies!("iPhone")

project = Project.new
project.name = "Fampus"
project.start_date = DateTime.parse("1/6/2010")
project.end_date = DateTime.parse("13/9/2010")
p.projects << project
project.save
project.set_technologies!("Rails")

project.save

u = User.new
u.username = "flux88"
u.email = "flux88@chaione.com"
u.password = "test123"
u.password_confirmation = "test123"
u.save

p = u.profile
p.name = "Ben Scheirman"

project = Project.new
project.name = "Bizeeti"
project.start_date = DateTime.parse("1/11/2010")
project.end_date = DateTime.parse("13/1/2011")
p.projects << project
project.save
project.set_technologies!("iPhone")

project = Project.new
project.name = "Safecell"
project.start_date = DateTime.parse("1/6/2009")
project.end_date = DateTime.parse("13/9/2010")
p.projects << project
project.save
project.set_technologies!("Rails")

project.save

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
talk.title = "Design Patterns"
talk.description = "Design patterns and stuff and how they are awesome"
talk.tags_text = "Design Patters, OOP, C#"
p.talks << talk
talk.save

talk = Talk.new
talk.title = "OOP"
talk.description = "SOLID and OOP"
talk.tags_text = "OOP, C#"
p.talks << talk
talk.save
