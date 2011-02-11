require 'yaml'

class StackOverflowProfileTagEvent < TagEvent

  SO_NAME = 0
  SO_COUNT = 1

  def set_tags
    so_tags = YAML.load(taggable.stack_overflow_tags)
    so_tags.each do |so_tag|
      tag so_tag[SO_NAME], :count => so_tag[SO_COUNT]
    end
  end

end
