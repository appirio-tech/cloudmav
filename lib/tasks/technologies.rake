require 'yaml'

namespace :codemav do    
  desc "Seed technologies from file"
  task :technologies_seed => :environment do
    
    file = YAML::load(File.open("lib/tasks/technologies.yml"))

    puts "Adding technologies..."
    technologies = []
    file.keys.each do |key|
      unless Technology.named(key).first
        t = Technology.new
        t.name = key
        t.tag! key
        unless file[key].nil?
          file[key].each do |tag|
            t.tag! tag
          end
        end
        t.save
        technologies << t
      end
    end
    puts "#{technologies.count} technologies added"
  end
end