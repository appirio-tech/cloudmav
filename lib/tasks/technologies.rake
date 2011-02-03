require 'yaml'

namespace :codemav do    
  desc "Seed technologies from file"
  task :technologies_seed => :environment do
    
    file = YAML::load(File.open("lib/tasks/technologies.yml"))

    puts "Adding technologies..."
    technologies = []
    file.keys.each do |key|
      key = key.strip
      unless Technology.named(key).first
        tag = Tag.new
        tag.name = key

        synonyms = file["synonyms"]
        unless synonyms.nil?
          synonyms = file["synonyms"].split(",").map{|s|s.strip}
          synonyms.each {|s| tag.add_synonym(s)}
        end
        tag.save

        type_name = file["type"]
        tech_type = TechnologyType.where(:name => type_name).first
        unless tech_type
          tech_type = TechnologyType.create(:name => type_name)
        end

        t = Technology.new
        t.name = key
        t.tag! key
        t.technology_type = tech_type
        t.save

        technologies << t
      end
    end
    puts "#{technologies.count} technologies added"
  end
end
