class JobTagEvent < TagEvent

  def set_tags
    find_tags_in(taggable.title)
    find_tags_in(taggable.description)
  end

end
