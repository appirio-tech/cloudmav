class SpeakerProfileTagEvent < TagEvent

  def set_tags
    taggable.profile.talks.each { |talk| import_tags_from(talk) }
  end

end

