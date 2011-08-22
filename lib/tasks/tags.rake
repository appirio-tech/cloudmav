namespace :codemav do    
  desc "Get tags from StackOverflow"
  task :import_stack_overflow_tags => :environment do
    tags = StackOverflow.get_tags
    tags["tags"].each do |tag|
      unless Tag.named(tag["name"]).first
        Tag.create(:name => tag["name"])
      end
    end

    tags_synonyms = StackOverflow.get_tags_synonyms
    tags_synonyms["tag_synonyms"].each do |tag_synonym|
      tag = Tag.named(tag_synonym["from_tag"]).first
      tag.add_synonym(tag_synonym["to_tag"]) unless tag.nil?
    end
  end
end

